import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> readToken() async {
    try {
      return await _storage.read(key: 'auth_token');
    } catch (e) {
      print('读取令牌失败: $e');
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'auth_token', value: token);
      print('存储令牌成功');
    } catch (e) {
      print('存储令牌失败: $e');
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'auth_token');
      print('删除令牌成功');
    } catch (e) {
      print('删除令牌失败: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await readToken();
    return token != null;
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final String userId = userData['user_id']?.toString() ?? '';
      final String name = userData['name']?.toString() ?? '';
      final int age = userData['age'] as int? ?? 0;
      final String gender = userData['gender']?.toString() ?? '';
      final String email = userData['email']?.toString() ?? '';
      final String password = userData['password']?.toString() ?? '';
      final String photo = userData['photo']?.toString() ?? '';
      final int firstLoginValue = userData['first_login'] as int? ?? 0;
      final bool firstLogin = firstLoginValue == 1;

      // 构建需要存储的数据的映射
      final Map<String, dynamic> dataToStore = {
        'user_id': userId,
        'name': name,
        'age': age,
        'gender': gender,
        'email': email,
        'password': password,
        'photo': photo,
        'first_login': firstLogin,
      };

      final userDataJson = json.encode(dataToStore);
      await _storage.write(key: 'user_data', value: userDataJson);
      print('存储用户数据成功');
    } catch (e) {
      print('存储用户数据失败: $e');
    }
  }

  Future<Map<String, dynamic>?> readUserData() async {
    try {
      final userDataJson = await _storage.read(key: 'user_data');
      if (userDataJson != null) {
        final userData = json.decode(userDataJson) as Map<String, dynamic>;
        return userData;
      }
    } catch (e) {
      print('读取用户数据失败: $e');
    }
    return null;
  }

  Future<void> deleteUserData() async {
    try {
      await _storage.delete(key: 'user_data');
      print('删除用户数据成功');
    } catch (e) {
      print('删除用户数据失败: $e');
    }
  }
}