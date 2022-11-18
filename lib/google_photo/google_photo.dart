import 'package:json_annotation/json_annotation.dart';

part 'google_photo.g.dart';

abstract class GooglePhotoPagingResponse {
  final String? nextPageToken;

  GooglePhotoPagingResponse(this.nextPageToken);
}

@JsonSerializable(createFactory: false)
class GooglePhotoPagingRequest {
  @JsonKey(includeIfNull: false)
  final String? pageSize;
  @JsonKey(includeIfNull: false)
  final String? pageToken;

  GooglePhotoPagingRequest({
    this.pageSize,
    this.pageToken,
  });

  Map<String, dynamic> toJson() => _$GooglePhotoPagingRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class SearchMediaItemRequest extends GooglePhotoPagingRequest {
  final String albumId;

  SearchMediaItemRequest({
    required this.albumId,
    super.pageSize,
    super.pageToken,
  });

  @override
  Map<String, dynamic> toJson() => _$SearchMediaItemRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class GetListAlbumResponse extends GooglePhotoPagingResponse {
  final List<Album>? albums;

  GetListAlbumResponse(
    this.albums,
    super.nextPageToken,
  );

  factory GetListAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListAlbumResponseFromJson(json);
}

@JsonSerializable(createFactory: false)
class CreateAlbumRequest {
  final Album album;

  CreateAlbumRequest(this.album);

  Map<String, dynamic> toJson() => _$CreateAlbumRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class CreateAlbumResponse {
  final Album albums;

  CreateAlbumResponse(
    this.albums,
  );

  factory CreateAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAlbumResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GetListMediaItemResponse extends GooglePhotoPagingResponse {
  final List<MediaItem>? mediaItems;

  GetListMediaItemResponse(
    this.mediaItems,
    super.nextPageToken,
  );

  factory GetListMediaItemResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListMediaItemResponseFromJson(json);
}

@JsonSerializable(createFactory: false)
class CreateMediaItemsRequest {
  @JsonKey(includeIfNull: false)
  final String? albumId;
  final List<NewMediaItem> newMediaItems;
  @JsonKey(includeIfNull: false)
  final AlbumPosition? albumPosition;

  CreateMediaItemsRequest({
    required this.newMediaItems,
    this.albumId,
    this.albumPosition,
  });

  Map<String, dynamic> toJson() => _$CreateMediaItemsRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class NewMediaItem {
  @JsonKey(includeIfNull: false)
  final String? albumId;
  @JsonKey(includeIfNull: false)
  final String? description;
  final SimpleMediaItem simpleMediaItem;
  @JsonKey(includeIfNull: false)
  final AlbumPosition? albumPosition;

  NewMediaItem({
    this.description,
    required this.simpleMediaItem,
    this.albumId,
    this.albumPosition,
  });

  Map<String, dynamic> toJson() => _$NewMediaItemToJson(this);
}

@JsonSerializable(createFactory: false)
class AlbumPosition {
  @JsonKey(includeIfNull: false)
  final String? position;
  @JsonKey(includeIfNull: false)
  final String? relativeMediaItemId;

  AlbumPosition({
    this.position,
    this.relativeMediaItemId,
  });

  Map<String, dynamic> toJson() => _$AlbumPositionToJson(this);
}

@JsonSerializable(createFactory: false)
class SimpleMediaItem {
  @JsonKey(includeIfNull: false)
  final String? fileName;
  final String uploadToken;

  SimpleMediaItem({
    this.fileName,
    required this.uploadToken,
  });

  Map<String, dynamic> toJson() => _$SimpleMediaItemToJson(this);
}

@JsonSerializable(createToJson: false)
class CreateMediaItemsResponse {
  final List<NewMediaItemResult> newMediaItemResults;

  CreateMediaItemsResponse(
    this.newMediaItemResults,
  );

  factory CreateMediaItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateMediaItemsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class NewMediaItemResult {
  final String uploadToken;
  final Status status;
  final MediaItem? mediaItem;

  NewMediaItemResult(this.uploadToken, this.status, this.mediaItem);

  factory NewMediaItemResult.fromJson(Map<String, dynamic> json) =>
      _$NewMediaItemResultFromJson(json);
}

@JsonSerializable(createToJson: false)
class Status {
  final int? code;
  final String message;

  Status(this.code, this.message);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

@JsonSerializable()
class Album {
  @JsonKey(includeIfNull: false)
  final String? id;
  final String title;
  @JsonKey(includeIfNull: false)
  final String? productUrl;
  @JsonKey(includeIfNull: false)
  final bool? isWriteable;
  @JsonKey(includeIfNull: false)
  final ShareInfo? shareInfo;
  @JsonKey(includeIfNull: false)
  final String? mediaItemsCount;
  @JsonKey(includeIfNull: false)
  final String? coverPhotoBaseUrl;
  @JsonKey(includeIfNull: false)
  final String? coverPhotoMediaItemId;

  Album({
    this.id,
    required this.title,
    this.productUrl,
    this.isWriteable,
    this.shareInfo,
    this.mediaItemsCount,
    this.coverPhotoBaseUrl,
    this.coverPhotoMediaItemId,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class ShareInfo {
  final SharedAlbumOptions sharedAlbumOptions;
  final String shareableUrl;
  final String shareToken;
  final bool isJoined;
  final bool isOwned;
  final bool isJoinable;

  ShareInfo(
    this.sharedAlbumOptions,
    this.shareableUrl,
    this.shareToken,
    this.isJoined,
    this.isOwned,
    this.isJoinable,
  );

  factory ShareInfo.fromJson(Map<String, dynamic> json) =>
      _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}

@JsonSerializable()
class SharedAlbumOptions {
  final bool isCollaborative;
  final bool isCommentable;

  SharedAlbumOptions(
    this.isCollaborative,
    this.isCommentable,
  );

  factory SharedAlbumOptions.fromJson(Map<String, dynamic> json) =>
      _$SharedAlbumOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SharedAlbumOptionsToJson(this);
}

@JsonSerializable()
class MediaItem {
  final String id;
  final String? description;
  final String productUrl;
  final String? baseUrl;
  final String mimeType;
  final MediaMetadata mediaMetadata;
  final ContributorInfo? contributorInfo;
  final String? fileName;

  MediaItem(
    this.id,
    this.description,
    this.productUrl,
    this.baseUrl,
    this.mimeType,
    this.mediaMetadata,
    this.contributorInfo,
    this.fileName,
  );

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemToJson(this);
}

@JsonSerializable()
class MediaMetadata {
  final String creationTime;
  final String width;
  final String height;
  final Photo? photo;
  final Video? video;

  MediaMetadata(
    this.creationTime,
    this.width,
    this.height,
    this.photo,
    this.video,
  );

  factory MediaMetadata.fromJson(Map<String, dynamic> json) =>
      _$MediaMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MediaMetadataToJson(this);
}

@JsonSerializable()
class Photo {
  final String? cameraMake;
  final String? cameraModel;
  final double? focalLength;
  final double? apertureFNumber;
  final int? isoEquivalent;
  final String? exposureTime;

  Photo(
    this.cameraMake,
    this.cameraModel,
    this.focalLength,
    this.apertureFNumber,
    this.isoEquivalent,
    this.exposureTime,
  );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class Video {
  final String? cameraMake;
  final String? cameraModel;
  final double? fps;
  @JsonKey(fromJson: _videoProcessingStatusFromJson)
  final VideoProcessingStatus? status;

  Video(this.cameraMake, this.cameraModel, this.fps, this.status);

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

VideoProcessingStatus _videoProcessingStatusFromJson(String value) {
  return VideoProcessingStatus.values
      .firstWhere((element) => element.value == value);
}

enum VideoProcessingStatus {
  unspecified('UNSPECIFIED'),
  processing('PROCESSING'),
  ready('READY'),
  fail('FAILED');

  final String value;

  const VideoProcessingStatus(this.value);
}

@JsonSerializable()
class ContributorInfo {
  final String profilePictureBaseUrl;
  final String displayName;

  ContributorInfo(this.profilePictureBaseUrl, this.displayName);

  factory ContributorInfo.fromJson(Map<String, dynamic> json) =>
      _$ContributorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContributorInfoToJson(this);
}
