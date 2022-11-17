part of 'photo_list_bloc.dart';

abstract class PhotoListState extends Equatable {
  const PhotoListState();
}

class PhotoListLoading extends PhotoListState {
  final bool isLoading;
  final LoadType loadType;

  const PhotoListLoading({
    this.isLoading = false,
    this.loadType = LoadType.refresh,
  });

  @override
  List<Object?> get props => [isLoading, loadType];
}

class PhotoListError extends PhotoListState {
  final AppError error;

  const PhotoListError(this.error);

  @override
  List<Object?> get props => [error];
}

enum LoadType {
  refresh,
  loadMore;
}

class PhotoListMediaItemLoaded extends PhotoListState {
  final List<MediaItemView> mediaItemViews;
  final List<MediaItem> mediaItems;
  final LoadType loadType;
  final String? nextPageToken;
  final bool hasError;

  const PhotoListMediaItemLoaded({
    this.mediaItemViews = const [],
    this.mediaItems = const [],
    this.loadType = LoadType.refresh,
    this.nextPageToken,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [
        mediaItemViews,
        mediaItems,
        loadType,
        nextPageToken,
        hasError,
      ];
}

class UploadProgress extends PhotoListState {
  final int current;
  final int total;

  const UploadProgress({
    required this.current,
    required this.total,
  });

  @override
  List<Object?> get props => [current, total];
}

class MediaItemCreated extends PhotoListState {
  @override
  List<Object?> get props => [];
}
