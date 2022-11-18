import 'dart:io' hide HttpResponse;

import 'package:dio/dio.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:injectable/injectable.dart';

import 'google_photo.dart';
import 'google_photo_service.dart';
import 'google_photo_upload_service.dart';

@injectable
class GooglePhotoRepository {
  final GooglePhotoService _googlePhotoService;
  final GooglePhotoUploadService _googlePhotoUploadService;

  GooglePhotoRepository(
    this._googlePhotoService,
    this._googlePhotoUploadService,
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
