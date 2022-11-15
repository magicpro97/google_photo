part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class GetMediaItems extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class UploadMedia extends HomePageEvent {
  final List<Media> _mediaList;

  const UploadMedia(this._mediaList);

  @override
  List<Object?> get props => [_mediaList];
}
