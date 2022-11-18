import 'package:google_photo/home/album_list/album_item_view.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../google_photo/google_photo.dart';
import 'album_create/media_item/album_media_item_view.dart';
import 'photo_list/media_item_view.dart';

@injectable
class MediaItemFactory {
  List<MediaItemView> generateMediaItemViews(
    List<MediaItem> mediaItems,
    void Function(MediaItem) onMediaItemPressed,
  ) {
    final List<MediaItemView> mediaItemViews = [];
    for (final mediaItem in mediaItems) {
      mediaItemViews.add(MediaItemView(
        mediaItem: mediaItem,
        onMediaItemPressed: onMediaItemPressed,
      ));
    }

    return mediaItemViews.toList(growable: false);
  }

  List<AlbumItemView> generateAlbumViews(
    List<Album> albums,
    void Function(Album) onAlbumItemPressed,
  ) {
    final List<AlbumItemView> albumItemViews = [];
    for (final album in albums) {
      albumItemViews.add(AlbumItemView(
        album: album,
        onAlbumPressed: onAlbumItemPressed,
      ));
    }

    return albumItemViews.toList(growable: false);
  }

  List<AlbumMediaItemView> generateAlbumMediaItemViews(
    List<Media> mediaList,
    void Function(Media) onMediaItemPressed,
    void Function(Media, String) onMediaItemUploaded,
  ) {
    final List<AlbumMediaItemView> albumMediaItemViews = [];
    for (final mediaList in mediaList) {
      albumMediaItemViews.add(AlbumMediaItemView(
        mediaItem: mediaList,
        onMediaItemPressed: onMediaItemPressed,
          onMediaItemUploaded: onMediaItemUploaded,
      ));
    }

    return albumMediaItemViews.toList(growable: false);
  }
}
