import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import 'google_photo.dart';

part 'google_photo_service.g.dart';

@RestApi()
abstract class GooglePhotoService {
  factory GooglePhotoService(Dio dio, {String? baseUrl}) = _GooglePhotoService;

  @GET('/albums')
  Future<GetListAlbumResponse> getAlbums(
    @Query('pageSize') String? pageSize,
    @Query('pageToken') String? pageToken,
  );

  @POST('/albums')
  Future<Album> createAlbum(@Body() CreateAlbumRequest createAlbumRequest);

  @PATCH('/albums/{id}')
  Future<Album> updateAlbum(
    @Path('id') String albumId,
    @Body() Album updateAlbumRequest, {
    @Query('updateMask') String? updateMask,
  });

  @GET('/mediaItems')
  Future<GetListMediaItemResponse> getMediaItems(
    @Query('pageSize') String? pageSize,
    @Query('pageToken') String? pageToken,
  );

  @PATCH('/mediaItems/{id}')
  Future<MediaItem> updateMediaItem(
    @Path('id') String id,
    @Query('updateMask') String updateMask,
  );

  @POST('/mediaItems:batchCreate')
  Future<CreateMediaItemsResponse> batchCreate(
    @Body() CreateMediaItemsRequest createMediaItemsRequest,
  );

  @POST('/mediaItems:search')
  Future<GetListMediaItemResponse> searchMediaItems(
    @Body() SearchMediaItemRequest searchMediaItemRequest,
  );

  @POST('/uploads')
  @MultiPart()
  @Headers({
    'Content-Type': 'application/octet-stream',
    'X-Goog-Upload-Protocol': 'raw',
  })
  Future<String> uploadMedia(
    @Part() File file,
    @Header('X-Goog-Upload-Content-Type') String mimeType, {
    @SendProgress() ProgressCallback? sendProgress,
    @CancelRequest() CancelToken? cancelToken,
  });
}
