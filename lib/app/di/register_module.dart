import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_photo/app/token_interceptor.dart';
import 'package:google_photo/google_photo/google_photo_service.dart';
import 'package:google_photo/shared/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../firebase_options.dart';

@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => Constants.baseUrl;

  @lazySingleton
  Dio getDio(
    @Named('BaseUrl') String baseUrl,
    TokenInterceptor tokenInterceptor,
  ) =>
      Dio(
        BaseOptions(
          baseUrl: baseUrl,
        ),
      )..interceptors.add(tokenInterceptor);

  @singleton
  GooglePhotoService getGooglePhotoService(
    Dio dio,
    @Named('BaseUrl') String baseUrl,
  ) =>
      GooglePhotoService(dio, baseUrl: baseUrl);

  @singleton
  GoogleSignIn get googleSignIn => GoogleSignIn(
        scopes: [
          // 'https://www.googleapis.com/auth/photoslibrary.readonly',
          'https://www.googleapis.com/auth/photoslibrary.appendonly',
          'https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata',
          'https://www.googleapis.com/auth/photoslibrary.edit.appcreateddata',
        ],
        clientId: Platform.isIOS
            ? DefaultFirebaseOptions.currentPlatform.iosClientId
            : DefaultFirebaseOptions.currentPlatform.androidClientId,
      );

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
          aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ));

  @lazySingleton
  FlutterUploader get flutterUploader => FlutterUploader();

  @lazySingleton
  Uuid get uuid => const Uuid();
}
