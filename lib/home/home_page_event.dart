part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class GetMediaItems extends HomePageEvent {
  final String? nextPageToken;

  const GetMediaItems({this.nextPageToken});

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

class CreateMediaItem extends HomePageEvent {
  final String uploadToken;

  const CreateMediaItem(this.uploadToken);

  @override
  List<Object?> get props => [uploadToken];
}
