import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  Future<http.Response> createUser(
      String name, int age, String gender, String email, String password) {
    final url = Uri.parse('http://61.61.81.242:3000/api/register');
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
    final url = Uri.parse('http://61.61.81.242:3000/api/login');
    final body = jsonEncode({'email': email, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    return http.post(url, headers: headers, body: body);
  }

  Future<http.Response> setFirstLoginStatus(
      String userId, bool isFirstLogin) async {
    final url = Uri.parse('http://61.61.81.242:3000/api/setFirstLoginStatus');
    final body = jsonEncode({'user_id': userId, 'isFirstLogin': isFirstLogin});
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  Future<void> savePreferences(String userId, List<String> preferences) async {
    final url = Uri.parse('http://61.61.81.242:3000/api/savePreferences');
    final body = {
      'userId': userId,
      'preferences': preferences,
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('保存偏好选项成功');
      } else {
        print('保存偏好选项失败: ${response.statusCode}');
      }
    } catch (error) {
      print('保存偏好选项失败: $error');
    }
  }

  Future<List<String>> getUserPreferences(String userId) async {
    final url = Uri.parse(
        'http://61.61.81.242:3000/api/getUserPreferences?user_id=$userId');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final preferences = jsonDecode(response.body).cast<String>();
      return preferences;
    } else {
      throw Exception('获取用户偏好失败');
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String email) async {
    final url = Uri.parse('http://61.61.81.242:3000/api/data?email=$email');
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
    var url = Uri.parse('http://61.61.81.242:3000/api/posts');
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

  static Future<List<dynamic>> fetchPosts(int currentPage, int perPage) async {
    try {
      final url = Uri.parse(
          'http://61.61.81.242:3000/api/getposts?page=$currentPage&per_page=$perPage');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> fetchedPosts = List.from(responseData);
        return fetchedPosts;
      } else {
        print('無法獲取文章資料: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('獲取文章資料時發生錯誤: $error');
      return [];
    }
  }
}
