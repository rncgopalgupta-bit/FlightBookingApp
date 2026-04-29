

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class AuthHelper {
  Future<void> login(String userType) async {
    await secureStorage.write(key: 'isLogin', value: 'true');
    await secureStorage.write(key: 'userType', value: userType);
  }
  Future<bool> isLoggedIn() async {
    final isLogin = await secureStorage.read(key: 'isLogin');
    return isLogin ==
        'true'; 
  }

  Future<String> getUserType() async {
    return await secureStorage.read(key: 'userType') ?? 'Null';
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'isLogin');
    await secureStorage.delete(key: 'userType');
  }
}
