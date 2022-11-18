part of 'album_media_item_view_bloc.dart';

abstract class AlbumMediaItemViewState extends Equatable {
  const AlbumMediaItemViewState();
}

class UploadProgress extends AlbumMediaItemViewState {
  final double progress;
  final bool hasError;
  final String? uploadToken;

  const UploadProgress({this.progress = 0, this.hasError = false, this.uploadToken});

  @override
  List<Object?> get props => [progress, hasError, uploadToken];
}
