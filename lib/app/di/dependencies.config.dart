// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import '../../authencation/authentication_storage.dart' as _i7;
import '../../google_photo/google_photo_repository.dart' as _i12;
import '../../google_photo/google_photo_service.dart' as _i11;
import '../../home/home_page_bloc.dart' as _i13;
import '../../home/media_item_factory.dart' as _i6;
import '../../login/login_page_bloc.dart' as _i8;
import '../token_interceptor.dart' as _i9;
import 'register_module.dart' as _i14; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.singleton<_i4.FlutterSecureStorage>(registerModule.flutterSecureStorage);
  gh.factory<_i5.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i6.MediaItemFactory>(() => _i6.MediaItemFactory());
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.singleton<_i7.AuthenticationStorage>(
      _i7.AuthenticationStorage(get<_i4.FlutterSecureStorage>()));
  gh.factory<_i8.LoginPageBloc>(() => _i8.LoginPageBloc(
        get<_i5.GoogleSignIn>(),
        get<_i7.AuthenticationStorage>(),
      ));
  gh.singleton<_i9.TokenInterceptor>(
      _i9.TokenInterceptor(get<_i7.AuthenticationStorage>()));
  gh.factory<_i10.Dio>(() => registerModule.getDio(
        get<String>(instanceName: 'BaseUrl'),
        get<_i9.TokenInterceptor>(),
      ));
  gh.singleton<_i11.GooglePhotoService>(registerModule.getGooglePhotoService(
    get<_i10.Dio>(),
    get<String>(instanceName: 'BaseUrl'),
  ));
  gh.factory<_i12.GooglePhotoRepository>(
      () => _i12.GooglePhotoRepository(get<_i11.GooglePhotoService>()));
  gh.factory<_i13.HomePageBloc>(() => _i13.HomePageBloc(
        get<_i12.GooglePhotoRepository>(),
        get<_i6.MediaItemFactory>(),
      ));
  return get;
}

class _$RegisterModule extends _i14.RegisterModule {}
