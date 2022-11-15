import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_photo/app/token_interceptor.dart';
import 'package:google_photo/google_photo/google_photo_service.dart';
import 'package:google_photo/shared/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../firebase_options.dart';

@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => Constants.baseUrl;

  Dio getDio(
    @Named('baseUrl') String baseUrl,
    TokenInterceptor tokenInterceptor,
  ) =>
      Dio(
        BaseOptions(
          baseUrl: baseUrl,
        ),
      )..interceptors.add(tokenInterceptor);

  GooglePhotoService getGooglePhotoService(
          Dio dio, @Named('baseUrl') String baseUrl) =>
      GooglePhotoService(dio, baseUrl: baseUrl);

  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: [
          // 'https://www.googleapis.com/auth/photoslibrary.readonly',
          // 'https://www.googleapis.com/auth/photoslibrary.appendonly',
          'https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata',
          'https://www.googleapis.com/auth/photoslibrary.edit.appcreateddata',
        ],
        clientId: Platform.isIOS
            ? DefaultFirebaseOptions.currentPlatform.iosClientId
            : DefaultFirebaseOptions.currentPlatform.androidClientId,
      );

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  TokenInterceptor getTokenInterceptor(GoogleSignIn googleSignIn) =>
      TokenInterceptor(googleSignIn);
}
