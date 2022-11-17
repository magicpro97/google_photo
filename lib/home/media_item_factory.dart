import 'package:injectable/injectable.dart';

import '../google_photo/google_photo.dart';
import 'media_item_view/media_item_view.dart';

@injectable
class MediaItemFactory {
  Future<List<MediaItemView>> generateMediaItemViews(
    List<MediaItem> mediaItems,
    void Function(MediaItem) onMediaItemPressed,
  ) async {
    final List<MediaItemView> mediaItemViews = [];
    for (final mediaItem in mediaItems) {
      mediaItemViews.add(MediaItemView(
        mediaItem: mediaItem,
        type: _getViewType(mediaItem.mimeType),
        onMediaItemPressed: onMediaItemPressed,
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
}
