import "package:flutter_secure_storage/flutter_secure_storage.dart";

class TokenService {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String accessToken, String refreshToken) async {
    await _storage.write(key: "access_token", value: accessToken);
    await _storage.write(key: "refresh_token", value: refreshToken);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: "access_token");
  }

  static Future<void> removeAccessToken() async {
    await _storage.delete(key: "access_token");
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: "refresh_token");
  }

  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: "refresh_token", value: token);
  }

  static Future<void> removeRefreshToken() async {
    await _storage.delete(key: "refresh_token");
  }

  static Future<void> removeToken() async {
    await _storage.deleteAll();
  }
}
