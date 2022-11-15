// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../../google_photo/google_photo_service.dart' as _i8;
import '../../login/login_page_bloc.dart' as _i5;
import '../token_interceptor.dart' as _i6;
import 'register_module.dart' as _i9; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i5.LoginPageBloc>(
      () => _i5.LoginPageBloc(get<_i4.GoogleSignIn>()));
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.factory<_i6.TokenInterceptor>(
      () => registerModule.getTokenInterceptor(get<_i4.GoogleSignIn>()));
  gh.factory<_i7.Dio>(() => registerModule.getDio(
        get<String>(instanceName: 'baseUrl'),
        get<_i6.TokenInterceptor>(),
      ));
  gh.factory<_i8.GooglePhotoService>(() => registerModule.getGooglePhotoService(
        get<_i7.Dio>(),
        get<String>(instanceName: 'baseUrl'),
      ));
  return get;
}

class _$RegisterModule extends _i9.RegisterModule {}
