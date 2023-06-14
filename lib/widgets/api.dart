import 'dart:convert';
import 'package:http/http.dart' as http;

class API {

  String ngrokUrl = "440b-61-61-81-242.jp.ngrok.io";

  Future<http.Response> createUser(
      String name, int age, String gender, String email, String password) {
    final url = Uri.parse('https://$ngrokUrl/api/register');
    final body = jsonEncode({
      'name': name,
      'age': age,
      'gender': gender,
      'email': email,
      'password': password
    });
    final headers = {'Content-Type': 'application/json'};
    return http.post(url, headers: headers, body: body);
  }

  Future<http.Response> login(String email, String password) {
    final url = Uri.parse('https://$ngrokUrl/api/login');
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    return http.post(url, headers: headers, body: body);
  }

  Future<http.Response> setFirstLoginStatus(
      String userId, bool isFirstLogin) async {
    final url = Uri.parse('https://$ngrokUrl/api/setFirstLoginStatus');
    final body = jsonEncode({'user_id': userId, 'isFirstLogin': isFirstLogin});
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  Future<void> savePreferences(String userId, List<String> preferences) async {
    final url = Uri.parse('https://$ngrokUrl/api/savePreferences');
    final body = {
      'userId': userId,
      'preferences': preferences,
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('保存偏好選項成功');
      } else {
        print('保存偏好選項失敗: ${response.statusCode}');
      }
    } catch (error) {
      print('保存偏好選項失敗: $error');
    }
  }

  Future<List<String>> getUserPreferences(String userId) async {
    final url = Uri.parse(
        'https://$ngrokUrl/api/getUserPreferences?user_id=$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final preferences = jsonDecode(response.body).cast<String>();
      return preferences;
    } else {
      throw Exception('获取用户偏好失败');
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String email) async {
    final url = Uri.parse('https://$ngrokUrl/api/data?email=$email');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<http.Response> createPost(
      String title,
      String type,
      String date,
      String time,
      String budget,
      String location,
      String content,
      String author) async {
    var url = Uri.parse('https://$ngrokUrl/api/posts');
    final headers = {'Content-Type': 'application/json'};

    // 要傳送的資料
    var data = {
      'title': title,
      'type': type,
      'date': date,
      'time': time,
      'budget': budget,
      'location': location,
      'content': content,
      'author': author
    };

    return http.post(url, headers: headers, body: json.encode(data));
  }

  Future<void> editPost(String postId, Map<String, dynamic> postData) async {
    final url = Uri.parse('$ngrokUrl/editPost/$postId');
    final response = await http.put(url, body: postData);

    if (response.statusCode == 200) {
      print('文章编辑成功');
    } else {
      print('文章编辑失败');
    }
  }

  Future<void> deletePost(int postId) async {
    final url = Uri.parse('https://$ngrokUrl/api/deletePost/$postId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 500) {
        print('刪除用戶失敗');
      } else {
        print('刪除用戶成功');
      }
    } catch (error) {
      print('發生錯誤：$error');
    }
  }

  Future<List<dynamic>> fetchPosts(String userId, int currentPage, int perPage) async {
    try {
      final url = Uri.parse(
          'https://$ngrokUrl/api/getposts?userId=$userId&page=$currentPage&per_page=$perPage');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> fetchedPosts = List.from(responseData);
        return fetchedPosts;
      } else {
        print('Failed to fetch posts: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching posts: $error');
      return [];
    }
  }

  Future<void> updateUserLocation(String userId, double latitude, double longitude) async {
    final url = Uri.parse('http://$ngrokUrl/api/updateUserLocation');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('更新用户位置信息成功');
    } else if (response.statusCode == 307) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final newUrl = Uri.parse(redirectUrl);
        final newResponse = await http.post(
          newUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userId': userId,
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
          }),
        );

        if (newResponse.statusCode == 200) {
          print('更新用户位置信息成功');
        } else {
          print('更新用户位置信息失败 ${newResponse.statusCode}');
        }
      } else {
        print('無法取得重定向 URL');
      }
    } else {
      print('更新用户位置信息失败 ${response.statusCode}');
    }
  }

}
