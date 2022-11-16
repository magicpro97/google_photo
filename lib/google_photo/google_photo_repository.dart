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

  Future<GetListMediaItemResponse> getMediaItem({
    String? nextPageToken,
  }) {
    return _googlePhotoService.getMediaItems(
      GooglePhotoPagingRequest(
        pageToken: nextPageToken,
      ),
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
}
