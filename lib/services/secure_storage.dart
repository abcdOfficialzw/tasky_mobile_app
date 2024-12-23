import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  final iOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const String token = 'access_token';
  static const String _refreshToken = 'refresh_token';
  static const String pensionNumber = "pension_number";

  Future<void> saveToken(String accessToken) async {
    await storage.write(key: token, value: accessToken, iOptions: iOptions);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await storage.write(
        key: _refreshToken, value: refreshToken, iOptions: iOptions);
  }

  Future<String?> getToken() async {
    return await storage.read(key: token, iOptions: iOptions);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: _refreshToken, iOptions: iOptions);
  }

  Future<void> clear() async {}
}
