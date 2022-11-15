import 'package:dio/dio.dart';
import 'package:google_photo/authencation/authentication_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenInterceptor extends Interceptor {
  final AuthenticationStorage _authenticationStorage;

  TokenInterceptor(this._authenticationStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authenticationStorage.getAccessToken();
    var newOptions = options;
    if (accessToken != null) {
      newOptions = options.copyWith(
        headers: {
          ...options.headers,
          'Authorization': 'Bearer $accessToken',
        },
      );
    }

    handler.next(newOptions);
  }
}
