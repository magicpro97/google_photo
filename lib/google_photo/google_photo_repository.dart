import 'dart:async';
import 'dart:convert';
import 'dart:io' hide HttpResponse;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:injectable/injectable.dart';

import '../authentication/authentication_storage.dart';
import 'google_photo.dart';
import 'google_photo_service.dart';
import 'google_photo_upload_service.dart';

typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

@injectable
class GooglePhotoRepository {
  final GooglePhotoService _googlePhotoService;
  final GooglePhotoUploadService _googlePhotoUploadService;
  final AuthenticationStorage _authenticationStorage;

  GooglePhotoRepository(
    this._googlePhotoService,
    this._googlePhotoUploadService,
    this._authenticationStorage,
  );

  Future<GetListMediaItemResponse> getMediaItems({
    String? pageToken,
  }) {
    return _googlePhotoService.getMediaItems(
      null,
      pageToken,
    );
  }

  Future<GetListMediaItemResponse> searchMediaItems({
    required String albumId,
    String? pageToken,
  }) {
    return _googlePhotoService.searchMediaItems(SearchMediaItemRequest(
      albumId: albumId,
      pageToken: pageToken,
    ));
  }

  Future<GetListAlbumResponse> getAlbums({
    String? pageToken,
  }) {
    return _googlePhotoService.getAlbums(
      null,
      pageToken,
    );
  }

  Future<CreateMediaItemsResponse> createMediaItems({
    String? albumId,
    required List<NewMediaItem> newMediaItems,
    AlbumPosition? albumPosition,
  }) {
    return _googlePhotoService.batchCreate(CreateMediaItemsRequest(
      newMediaItems: newMediaItems,
      albumId: albumId,
      albumPosition: albumPosition,
    ));
  }

  Future<String> uploadMediaItemsBackground({
    required String mimeType,
    required String filePath,
    String? tag,
  }) {
    return _googlePhotoUploadService.uploadMedias(
      mimeType: mimeType,
      filePath: filePath,
      tag: tag,
    );
  }

  Stream<UploadTaskResponse> uploadMediaItemResponseById$(String taskUploadId) {
    return _googlePhotoUploadService.uploadResponseById$(taskUploadId);
  }

  Stream<UploadTaskProgress> uploadMediaItemProgressById$(String taskUploadId) {
    return _googlePhotoUploadService.uploadProgressById$(taskUploadId);
  }

  Stream<UploadTaskResponse> get uploadMediaItemResponse$ =>
      _googlePhotoUploadService.uploadResponse$;

  Stream<UploadTaskProgress> get uploadMediaItemProgress$ =>
      _googlePhotoUploadService.uploadProgress$;

  Future<void> cancelUploadTask(String taskId) {
    return _googlePhotoUploadService.cancel(taskId);
  }

  Future<String> uploadMediaItem({
    required String mimeType,
    required File file,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) {
    return _googlePhotoService.uploadMedia(
      file,
      mimeType,
      cancelToken: cancelToken,
      sendProgress: onSendProgress,
    );
  }

  Future<String> uploadMediaItemV2({
    required String mimeType,
    required File file,
    OnUploadProgressCallback? onUploadProgress,
  }) async {
    final httpClient = HttpClient();
    // Get the filename of the image
    final fileStream = file.openRead();
    final filename = path.basename(file.path);
    final totalByteLength = await file.length();

    // Set up the headers required for this request.
    final headers = <String, String>{};
    headers['Authorization'] =
        'Bearer ${await _authenticationStorage.getAccessToken()}';
    headers['Content-type'] = 'application/octet-stream';
    headers['X-Goog-Upload-Protocol'] = 'raw';
    headers['X-Goog-Upload-File-Name'] = filename;

    // Make the HTTP request to upload the image. The file is sent in the body.
    final request = await httpClient.postUrl(
      Uri.parse('https://photoslibrary.googleapis.com/v1/uploads'),
      // body: image.readAsBytesSync(),
      // headers: headers,
    );

    request.contentLength = totalByteLength;

    for (var e in headers.entries) {
      request.headers.set(e.key, e.value);
    }
    var byteCount = 0;
    final streamUpload = fileStream.transform<List<int>>(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }

          sink.add(data);
        },
        handleError: (error, stack, sink) {
          if (kDebugMode) {
            print(error.toString());
          }
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final response = await request.close();

    return _readResponseAsString(response);
  }

  Future<String> _readResponseAsString(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  Future<Album> createAlbum(Album album) {
    return _googlePhotoService.createAlbum(CreateAlbumRequest(album));
  }

  Future<Album> updateAlbum(Album album, {String? updateMask}) {
    return _googlePhotoService.updateAlbum(
      album.id!,
      album,
      updateMask: updateMask,
    );
  }
}
