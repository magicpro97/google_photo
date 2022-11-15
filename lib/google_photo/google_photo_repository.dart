import 'package:injectable/injectable.dart';

import 'google_photo.dart';
import 'google_photo_service.dart';

@injectable
class GooglePhotoRepository {
  final GooglePhotoService _googlePhotoService;

  GooglePhotoRepository(this._googlePhotoService);

  Future<GetListMediaItemResponse> getMediaItem({
    String? nextPageToken,
  }) {
    return _googlePhotoService.getMediaItems(
      GooglePhotoPagingRequest(
        pageToken: nextPageToken,
      ),
    );
  }
}
