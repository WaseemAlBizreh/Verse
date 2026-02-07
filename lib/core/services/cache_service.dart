import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

const kUserLoginModelKey = "kUserLoginModelKey";
const kUserTokenKey = "kUserTokenKey";
const kUserRefreshTokenKey = "kUserRefreshTokenKey";
const kFCMTokenKey = "kFCMTokenKey";
const kFirstOpen = "kFirstOpen";
const kLang = "kLang";
const kMultiTypeSettingsKey = "kMultiTypeSettingsKey";
const kVisualSettingsKey = "kVisualSettingsKey";
const kAppVersionsKey = "kAppVersionsKey";
const kContactUsTypesKey = "kContactUsTypesKey";

@singleton
class CacheService {
  final FlutterSecureStorage _storage;

  CacheService() : _storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    return await _storage.containsKey(key: kUserLoginModelKey);
  }

  Future<void> deleteCurrentUserAndToken() async {
    await _storage.delete(key: kUserLoginModelKey);
    await _storage.delete(key: kUserTokenKey);
    await _storage.delete(key: kUserRefreshTokenKey);
  }

  Future<void> updateUserInfo(UserModel user) async {
    await _storage.write(key: kUserLoginModelKey, value: user.toRawJson());
  }

  Future<void> storeLoggedInUserTokens(
    UserModel user,
    String token,
    String refreshToken,
  ) async {
    await _storage.write(key: kUserLoginModelKey, value: user.toRawJson());
    await _storage.write(key: kUserTokenKey, value: token);
    await _storage.write(key: kUserRefreshTokenKey, value: refreshToken);
  }

  Future<UserModel> getLoggedInUser() async {
    final result = await _storage.read(key: kUserLoginModelKey);
    if (result == null) {
      return UserModel.emptyUser();
    }
    return UserModel.fromRawJson(result);
  }

  Future<void> storeUserToken(String token) async {
    await _storage.write(key: kUserTokenKey, value: token);
  }

  Future<String?> getUserToken() async {
    return await _storage.read(key: kUserTokenKey);
  }

  Future<void> storeUserRefreshToken(String refreshToken) async {
    await _storage.write(key: kUserRefreshTokenKey, value: refreshToken);
  }

  Future<String?> getUserRefreshToken() async {
    return await _storage.read(key: kUserRefreshTokenKey);
  }

  Future<void> storeFCMToken(String fCMToken) async {
    await _storage.write(key: kFCMTokenKey, value: fCMToken);
  }

  Future<String?> getFCMToken() async {
    return await _storage.read(key: kFCMTokenKey);
  }

  Future<void> setFirstOpen() async {
    await _storage.write(key: kFirstOpen, value: 'true');
  }

  Future<String> getLanguage() async {
    return await _storage.read(key: kLang) ?? 'en';
  }

  Future<void> saveLanguage(String code) async {
    await _storage.write(key: kLang, value: code);
  }

  Future<bool> checkFirstOpen() async {
    final value = await _storage.read(key: kFirstOpen);
    return value == 'true';
  }
}
