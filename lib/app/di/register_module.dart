import 'package:dio/dio.dart';
import 'package:google_photo/google_photo/google_photo_service.dart';
import 'package:google_photo/shared/constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => Constants.baseUrl;

  Dio getDio(@Named('baseUrl') String baseUrl) => Dio(BaseOptions(
        baseUrl: baseUrl,
      ));

  GooglePhotoService getGooglePhotoService(
          Dio dio, @Named('baseUrl') String baseUrl) =>
      GooglePhotoService(dio, baseUrl: baseUrl);
}
