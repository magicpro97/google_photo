// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GooglePhotoPagingRequestToJson(
    GooglePhotoPagingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('pageToken', instance.pageToken);
  return val;
}

GetListAlbumResponse _$GetListAlbumResponseFromJson(
        Map<String, dynamic> json) =>
    GetListAlbumResponse(
      (json['albums'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$CreateAlbumRequestToJson(CreateAlbumRequest instance) =>
    <String, dynamic>{
      'album': instance.album,
    };

CreateAlbumResponse _$CreateAlbumResponseFromJson(Map<String, dynamic> json) =>
    CreateAlbumResponse(
      (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
    );

GetListMediaItemResponse _$GetListMediaItemResponseFromJson(
        Map<String, dynamic> json) =>
    GetListMediaItemResponse(
      (json['mediaItems'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['nextPageToken'] as String?,
    );

Map<String, dynamic> _$CreateMediaItemsRequestToJson(
        CreateMediaItemsRequest instance) =>
    <String, dynamic>{
      'newMediaItems': instance.newMediaItems,
    };

Map<String, dynamic> _$NewMediaItemToJson(NewMediaItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('albumId', instance.albumId);
  writeNotNull('description', instance.description);
  val['simpleMediaItem'] = instance.simpleMediaItem;
  writeNotNull('albumPosition', instance.albumPosition);
  return val;
}

Map<String, dynamic> _$AlbumPositionToJson(AlbumPosition instance) =>
    <String, dynamic>{
      'position': instance.position,
      'relativeMediaItemId': instance.relativeMediaItemId,
    };

Map<String, dynamic> _$SimpleMediaItemToJson(SimpleMediaItem instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'uploadToken': instance.uploadToken,
    };

CreateMediaItemsResponse _$CreateMediaItemsResponseFromJson(
        Map<String, dynamic> json) =>
    CreateMediaItemsResponse(
      (json['newMediaItemResults'] as List<dynamic>)
          .map((e) => NewMediaItemResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

NewMediaItemResult _$NewMediaItemResultFromJson(Map<String, dynamic> json) =>
    NewMediaItemResult(
      json['uploadToken'] as String,
      Status.fromJson(json['status'] as Map<String, dynamic>),
      json['mediaItem'] == null
          ? null
          : MediaItem.fromJson(json['mediaItem'] as Map<String, dynamic>),
    );

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      json['code'] as int?,
      json['message'] as String,
    );

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['id'] as String,
      json['title'] as String,
      json['productUrl'] as String,
      json['isWriteable'] as bool?,
      json['shareInfo'] == null
          ? null
          : ShareInfo.fromJson(json['shareInfo'] as Map<String, dynamic>),
      json['mediaItemsCount'] as String,
      json['coverPhotoBaseUrl'] as String,
      json['coverPhotoMediaItemId'] as String,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'productUrl': instance.productUrl,
      'isWriteable': instance.isWriteable,
      'shareInfo': instance.shareInfo,
      'mediaItemsCount': instance.mediaItemsCount,
      'coverPhotoBaseUrl': instance.coverPhotoBaseUrl,
      'coverPhotoMediaItemId': instance.coverPhotoMediaItemId,
    };

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) => ShareInfo(
      SharedAlbumOptions.fromJson(
          json['sharedAlbumOptions'] as Map<String, dynamic>),
      json['shareableUrl'] as String,
      json['shareToken'] as String,
      json['isJoined'] as bool,
      json['isOwned'] as bool,
      json['isJoinable'] as bool,
    );

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'sharedAlbumOptions': instance.sharedAlbumOptions,
      'shareableUrl': instance.shareableUrl,
      'shareToken': instance.shareToken,
      'isJoined': instance.isJoined,
      'isOwned': instance.isOwned,
      'isJoinable': instance.isJoinable,
    };

SharedAlbumOptions _$SharedAlbumOptionsFromJson(Map<String, dynamic> json) =>
    SharedAlbumOptions(
      json['isCollaborative'] as bool,
      json['isCommentable'] as bool,
    );

Map<String, dynamic> _$SharedAlbumOptionsToJson(SharedAlbumOptions instance) =>
    <String, dynamic>{
      'isCollaborative': instance.isCollaborative,
      'isCommentable': instance.isCommentable,
    };

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) => MediaItem(
      json['id'] as String,
      json['description'] as String?,
      json['productUrl'] as String,
      json['baseUrl'] as String,
      json['mimeType'] as String,
      MediaMetadata.fromJson(json['mediaMetadata'] as Map<String, dynamic>),
      json['contributorInfo'] == null
          ? null
          : ContributorInfo.fromJson(
              json['contributorInfo'] as Map<String, dynamic>),
      json['fileName'] as String?,
    );

Map<String, dynamic> _$MediaItemToJson(MediaItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'productUrl': instance.productUrl,
      'baseUrl': instance.baseUrl,
      'mimeType': instance.mimeType,
      'mediaMetadata': instance.mediaMetadata,
      'contributorInfo': instance.contributorInfo,
      'fileName': instance.fileName,
    };

MediaMetadata _$MediaMetadataFromJson(Map<String, dynamic> json) =>
    MediaMetadata(
      json['creationTime'] as String,
      json['width'] as String,
      json['height'] as String,
      json['photo'] == null
          ? null
          : Photo.fromJson(json['photo'] as Map<String, dynamic>),
      json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaMetadataToJson(MediaMetadata instance) =>
    <String, dynamic>{
      'creationTime': instance.creationTime,
      'width': instance.width,
      'height': instance.height,
      'photo': instance.photo,
      'video': instance.video,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      json['cameraMake'] as String?,
      json['cameraModel'] as String?,
      (json['focalLength'] as num?)?.toDouble(),
      (json['apertureFNumber'] as num?)?.toDouble(),
      json['isoEquivalent'] as int?,
      json['exposureTime'] as String?,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'cameraMake': instance.cameraMake,
      'cameraModel': instance.cameraModel,
      'focalLength': instance.focalLength,
      'apertureFNumber': instance.apertureFNumber,
      'isoEquivalent': instance.isoEquivalent,
      'exposureTime': instance.exposureTime,
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      json['cameraMake'] as String,
      json['cameraModel'] as String,
      (json['fps'] as num).toDouble(),
      _videoProcessingStatusFromJson(json['status'] as String),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'cameraMake': instance.cameraMake,
      'cameraModel': instance.cameraModel,
      'fps': instance.fps,
      'status': _$VideoProcessingStatusEnumMap[instance.status]!,
    };

const _$VideoProcessingStatusEnumMap = {
  VideoProcessingStatus.unspecified: 'unspecified',
  VideoProcessingStatus.processing: 'processing',
  VideoProcessingStatus.ready: 'ready',
  VideoProcessingStatus.fail: 'fail',
};

ContributorInfo _$ContributorInfoFromJson(Map<String, dynamic> json) =>
    ContributorInfo(
      json['profilePictureBaseUrl'] as String,
      json['displayName'] as String,
    );

Map<String, dynamic> _$ContributorInfoToJson(ContributorInfo instance) =>
    <String, dynamic>{
      'profilePictureBaseUrl': instance.profilePictureBaseUrl,
      'displayName': instance.displayName,
    };
