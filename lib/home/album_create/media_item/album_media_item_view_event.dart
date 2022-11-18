part of 'album_media_item_view_bloc.dart';

abstract class AlbumMediaItemViewEvent extends Equatable {
  const AlbumMediaItemViewEvent();
}

class Upload extends AlbumMediaItemViewEvent {
  final Media mediaItem;

  const Upload({required this.mediaItem});

  @override
  List<Object?> get props => [mediaItem];
}
