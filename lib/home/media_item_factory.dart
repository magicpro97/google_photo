import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../google_photo/google_photo.dart';
import 'media_item_view/media_item_view.dart';

@injectable
class MediaItemFactory {
  Future<List<MediaItemView>> generateMediaItemViews(
      List<MediaItem> mediaItems) async {
    final List<MediaItemView> mediaItemViews = [];
    for (final mediaItem in mediaItems) {
      mediaItemViews.add(MediaItemView(
        mediaItem: mediaItem,
        type: _getViewType(mediaItem.mimeType),
        thumbnailFile: await _generateVideoThumbnail(mediaItem.productUrl),
      ));
    }

    return mediaItemViews.toList(growable: false);
  }

  ViewType _getViewType(String mimeType) {
    if (mimeType.contains('image')) {
      return ViewType.image;
    }

    return ViewType.video;
  }

  Future<String?> _generateVideoThumbnail(String videoUrl) async {
    return VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
  }
}
