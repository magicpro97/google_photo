import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TokenInterceptor extends Interceptor {
  final GoogleSignIn _googleSignIn;

  TokenInterceptor(this._googleSignIn);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentUser = _googleSignIn.currentUser;
    var newOptions = options;
    if (currentUser != null) {
      final authentication = await currentUser.authentication;
      newOptions = options.copyWith(
        headers: {
          ...options.headers,
          'Authorization': 'Bearer ${authentication.accessToken}',
        },
      );
    }

    handler.next(newOptions);
  }
}
