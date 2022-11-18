part of 'album_create_page_bloc.dart';

abstract class AlbumCreatePageState extends Equatable {
  const AlbumCreatePageState();
}

class AlbumCreateLoading extends AlbumCreatePageState {
  final bool isLoading;

  const AlbumCreateLoading({
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading];
}

class AlbumCreateError extends AlbumCreatePageState {
  final AppError error;

  const AlbumCreateError(this.error);

  @override
  List<Object?> get props => [error];
}

class UploadingMedia extends AlbumCreatePageState {
  final List<AlbumMediaItemView> albumMediaItemViews;

  const UploadingMedia(this.albumMediaItemViews);

  @override
  List<Object?> get props => [albumMediaItemViews];
}

class AlbumCreated extends AlbumCreatePageState {
  final String albumId;

  const AlbumCreated(this.albumId);

  @override
  List<Object?> get props => [albumId];
}
