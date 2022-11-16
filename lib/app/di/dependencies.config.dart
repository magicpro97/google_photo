// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:flutter_uploader/flutter_uploader.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../../authentication/authentication_storage.dart' as _i8;
import '../../google_photo/google_photo_repository.dart' as _i14;
import '../../google_photo/google_photo_service.dart' as _i13;
import '../../google_photo/google_photo_upload_service.dart' as _i9;
import '../../home/home_page_bloc.dart' as _i15;
import '../../home/media_item_factory.dart' as _i7;
import '../../login/login_page_bloc.dart' as _i10;
import '../token_interceptor.dart' as _i11;
import 'register_module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.singleton<_i4.FlutterSecureStorage>(registerModule.flutterSecureStorage);
  gh.lazySingleton<_i5.FlutterUploader>(() => registerModule.flutterUploader);
  gh.singleton<_i6.GoogleSignIn>(registerModule.googleSignIn);
  gh.factory<_i7.MediaItemFactory>(() => _i7.MediaItemFactory());
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.singleton<_i8.AuthenticationStorage>(
      _i8.AuthenticationStorage(get<_i4.FlutterSecureStorage>()));
  gh.lazySingleton<_i9.GooglePhotoUploadService>(
      () => _i9.GooglePhotoUploadService(
            get<_i5.FlutterUploader>(),
            get<String>(instanceName: 'BaseUrl'),
            get<_i8.AuthenticationStorage>(),
          ));
  gh.factory<_i10.LoginPageBloc>(() => _i10.LoginPageBloc(
        get<_i6.GoogleSignIn>(),
        get<_i8.AuthenticationStorage>(),
      ));
  gh.singleton<_i11.TokenInterceptor>(
      _i11.TokenInterceptor(get<_i8.AuthenticationStorage>()));
  gh.singleton<_i12.Dio>(registerModule.getDio(
    get<String>(instanceName: 'BaseUrl'),
    get<_i11.TokenInterceptor>(),
  ));
  gh.singleton<_i13.GooglePhotoService>(registerModule.getGooglePhotoService(
    get<_i12.Dio>(),
    get<String>(instanceName: 'BaseUrl'),
  ));
  gh.factory<_i14.GooglePhotoRepository>(() => _i14.GooglePhotoRepository(
        get<_i13.GooglePhotoService>(),
        get<_i9.GooglePhotoUploadService>(),
      ));
  gh.factory<_i15.HomePageBloc>(() => _i15.HomePageBloc(
        get<_i14.GooglePhotoRepository>(),
        get<_i7.MediaItemFactory>(),
      ));
  return get;
}

class _$RegisterModule extends _i16.RegisterModule {}
