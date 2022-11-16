import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthenticationStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  static const accessToken = 'accessToken';

  AuthenticationStorage(this._flutterSecureStorage);

  Future<void> saveAccessToken(String token) =>
      _flutterSecureStorage.write(key: accessToken, value: token);

  Future<String?> getAccessToken() =>
      _flutterSecureStorage.read(key: accessToken);
}
