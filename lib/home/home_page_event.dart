part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class GetMediaItems extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class UploadMedia extends HomePageEvent {
  final List<Media> mediaList;

  const UploadMedia(this.mediaList);

  @override
  List<Object?> get props => [mediaList];
}

class UpdateUploadStatus extends HomePageEvent {
  final int current;
  final int total;

  const UpdateUploadStatus({
    required this.current,
    required this.total,
  });

  @override
  List<Object?> get props => [current, total];
}
