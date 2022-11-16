import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'google_photo.dart';

part 'google_photo_service.g.dart';

@RestApi()
abstract class GooglePhotoService {
  factory GooglePhotoService(Dio dio, {String? baseUrl}) = _GooglePhotoService;

  @GET('/albums')
  Future<GetListAlbumResponse> getAlbums();

  @POST('/albums')
  Future<GetListAlbumResponse> createAlbum(
      @Body() CreateAlbumRequest createAlbumRequest);

  @GET('/mediaItems')
  Future<GetListMediaItemResponse> getMediaItems(
    @Body() GooglePhotoPagingRequest googlePhotoPagingRequest,
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
}
