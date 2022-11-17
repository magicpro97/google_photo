part of 'album_create_page_bloc.dart';

abstract class AlbumCreatePageEvent extends Equatable {
  const AlbumCreatePageEvent();
}

class UploadMedia extends AlbumCreatePageEvent {
  final List<Media> mediaList;

  const UploadMedia(this.mediaList);

  @override
  List<Object?> get props => [mediaList];
}
