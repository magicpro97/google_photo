part of 'photo_list_bloc.dart';

abstract class PhotoListEvent extends Equatable {
  const PhotoListEvent();
}

class UploadMedia extends PhotoListEvent {
  final List<Media> mediaList;

  const UploadMedia(this.mediaList);

  @override
  List<Object?> get props => [mediaList];
}

class GetMediaItems extends PhotoListEvent {
  final LoadType loadType;
  final String? nextPageToken;

  const GetMediaItems({
    this.nextPageToken,
    this.loadType = LoadType.refresh,
  });

  @override
  List<Object?> get props => [nextPageToken, loadType];
}

class UpdateUploadStatus extends PhotoListEvent {
  final int current;
  final int total;

  const UpdateUploadStatus({
    required this.current,
    required this.total,
  });

  @override
  List<Object?> get props => [current, total];
}

class CreateMediaItem extends PhotoListEvent {
  final String? uploadToken;

  const CreateMediaItem({this.uploadToken});

  @override
  List<Object?> get props => [uploadToken];
}