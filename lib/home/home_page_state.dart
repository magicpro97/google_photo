part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageLoading extends HomePageState {
  final bool isLoading;

  const HomePageLoading(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class HomePageError extends HomePageState {
  final AppError error;

  const HomePageError(this.error);

  @override
  List<Object?> get props => [error];
}

class HomePageMediaItemLoaded extends HomePageState {
  final List<MediaItemView> mediaItemViews;

  const HomePageMediaItemLoaded(this.mediaItemViews);

  @override
  List<Object?> get props => [mediaItemViews];
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
