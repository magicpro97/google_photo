part of 'album_create_page_bloc.dart';

abstract class AlbumCreatePageEvent extends Equatable {
  const AlbumCreatePageEvent();
}

class UploadMedia extends AlbumCreatePageEvent {
  final List<Media> mediaList;

  const UploadMedia({required this.mediaList});

  @override
  List<Object?> get props => [mediaList];
}

class UpdateUploadStatus extends AlbumCreatePageEvent {
  final int current;
  final int total;

  const UpdateUploadStatus({
    required this.current,
    required this.total,
  });

  @override
  List<Object?> get props => [current, total];
}

class CreateAlbum extends AlbumCreatePageEvent {
  final String albumTitle;

  const CreateAlbum(this.albumTitle);

  @override
  List<Object?> get props => [albumTitle];
}

class UpdateAlbum extends AlbumCreatePageEvent {
  final String albumId;
  final String albumTitle;

  const UpdateAlbum({
    required this.albumTitle,
    required this.albumId,
  });

  @override
  List<Object?> get props => [
        albumTitle,
        albumId,
      ];
}

class CreateMediaItem extends AlbumCreatePageEvent {
  final String uploadToken;
  final String albumId;

  const CreateMediaItem({
    required this.uploadToken,
    required this.albumId,
  });

  @override
  List<Object?> get props => [
        uploadToken,
        albumId,
      ];
}
