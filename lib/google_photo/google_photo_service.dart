import 'package:dio/dio.dart';
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
  Future<GetListAlbumResponse> createAlbum(
      @Body() CreateAlbumRequest createAlbumRequest);

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
}
