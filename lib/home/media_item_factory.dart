import 'package:google_photo/home/album_item_view/album_item_view.dart';
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

  Future<List<AlbumItemView>> generateAlbumViews(
    List<Album> albums,
    void Function(Album) onAlbumItemPressed,
  ) async {
    final List<AlbumItemView> albumItemViews = [];
    for (final album in albums) {
      albumItemViews.add(AlbumItemView(
        album: album,
        onAlbumPressed: onAlbumItemPressed,
      ));
    }

    return albumItemViews.toList(growable: false);
  }

  ViewType _getViewType(String mimeType) {
    if (mimeType.contains('image')) {
      return ViewType.image;
    }

    return ViewType.video;
  }
}
