part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageLoading extends HomePageState {
  final bool isLoading;
  final LoadType loadType;

  const HomePageLoading({
    this.isLoading = false,
    this.loadType = LoadType.refresh,
  });

  @override
  List<Object?> get props => [isLoading, loadType];
}

class HomePageError extends HomePageState {
  final AppError error;

  const HomePageError(this.error);

  @override
  List<Object?> get props => [error];
}

enum LoadType {
  refresh,
  loadMore;
}

class HomePageMediaItemLoaded extends HomePageState {
  final List<MediaItemView> mediaItemViews;
  final LoadType loadType;
  final String? nextPageToken;
  final bool hasError;

  const HomePageMediaItemLoaded({
    this.mediaItemViews = const [],
    this.loadType = LoadType.refresh,
    this.nextPageToken,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [
        mediaItemViews,
        loadType,
        nextPageToken,
        hasError,
      ];
}

class UploadProgress extends HomePageState {
  final int current;
  final int total;

  const UploadProgress({
    required this.current,
    required this.total,
  });

  @override
  List<Object?> get props => [current, total];
}
