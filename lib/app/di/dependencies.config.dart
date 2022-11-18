// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i13;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:flutter_uploader/flutter_uploader.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:uuid/uuid.dart' as _i8;

import '../../authentication/authentication_storage.dart' as _i9;
import '../../google_photo/google_photo_repository.dart' as _i15;
import '../../google_photo/google_photo_service.dart' as _i14;
import '../../google_photo/google_photo_upload_service.dart' as _i10;
import '../../home/album_create/album_create_page_bloc.dart' as _i18;
import '../../home/album_create/media_item/album_media_item_view_bloc.dart'
    as _i19;
import '../../home/home_page_bloc.dart' as _i16;
import '../../home/media_item_factory.dart' as _i7;
import '../../home/photo_list/photo_list_bloc.dart' as _i17;
import '../../login/login_page_bloc.dart' as _i11;
import '../token_interceptor.dart' as _i12;
import 'register_module.dart' as _i20; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i8.Uuid>(() => registerModule.uuid);
  gh.singleton<_i9.AuthenticationStorage>(
      _i9.AuthenticationStorage(get<_i4.FlutterSecureStorage>()));
  gh.lazySingleton<_i10.GooglePhotoUploadService>(
      () => _i10.GooglePhotoUploadService(
            get<_i5.FlutterUploader>(),
            get<String>(instanceName: 'BaseUrl'),
            get<_i9.AuthenticationStorage>(),
          ));
  gh.factory<_i11.LoginPageBloc>(() => _i11.LoginPageBloc(
        get<_i6.GoogleSignIn>(),
        get<_i9.AuthenticationStorage>(),
      ));
  gh.singleton<_i12.TokenInterceptor>(
      _i12.TokenInterceptor(get<_i9.AuthenticationStorage>()));
  gh.lazySingleton<_i13.Dio>(() => registerModule.getDio(
        get<String>(instanceName: 'BaseUrl'),
        get<_i12.TokenInterceptor>(),
      ));
  gh.singleton<_i14.GooglePhotoService>(registerModule.getGooglePhotoService(
    get<_i13.Dio>(),
    get<String>(instanceName: 'BaseUrl'),
  ));
  gh.factory<_i15.GooglePhotoRepository>(() => _i15.GooglePhotoRepository(
        get<_i14.GooglePhotoService>(),
        get<_i10.GooglePhotoUploadService>(),
        get<_i9.AuthenticationStorage>(),
      ));
  gh.factory<_i16.HomePageBloc>(() => _i16.HomePageBloc(
        get<_i15.GooglePhotoRepository>(),
        get<_i7.MediaItemFactory>(),
      ));
  gh.factory<_i17.PhotoListBloc>(() => _i17.PhotoListBloc(
        get<_i15.GooglePhotoRepository>(),
        get<_i7.MediaItemFactory>(),
      ));
  gh.factory<_i18.AlbumCreatePageBloc>(() => _i18.AlbumCreatePageBloc(
        get<_i7.MediaItemFactory>(),
        get<_i15.GooglePhotoRepository>(),
      ));
  gh.factory<_i19.AlbumMediaItemViewBloc>(
      () => _i19.AlbumMediaItemViewBloc(get<_i15.GooglePhotoRepository>()));
  return get;
}

class _$RegisterModule extends _i20.RegisterModule {}
