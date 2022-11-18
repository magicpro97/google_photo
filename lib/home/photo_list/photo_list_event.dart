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
  final String? albumId;
  final String? nextPageToken;

  const GetMediaItems({
    this.nextPageToken,
    this.loadType = LoadType.refresh,
    this.albumId,
  });

  @override
  List<Object?> get props => [
        nextPageToken,
        loadType,
        albumId,
      ];
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

class CreateMediaItems extends PhotoListEvent {
  final List<String> uploadTokens;

  const CreateMediaItems({required this.uploadTokens});

  @override
  List<Object?> get props => [uploadTokens];
}
