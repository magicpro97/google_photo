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

  Future<CreateMediaItemsResponse> createMediaItems(
      List<NewMediaItem> newMediaItems) {
    return _googlePhotoService
        .batchCreate(CreateMediaItemsRequest(newMediaItems));
  }

  Future<String> uploadMediaItems({
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
}
