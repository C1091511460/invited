import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> createUser(String name, int age, String gender, String email, String password) {
  final url = Uri.parse('http://192.168.50.134:3000/api/register');
  final body = jsonEncode({'name': name, 'age': age, 'gender': gender, 'email': email, 'password': password});
  final headers = {'Content-Type': 'application/json'};
  return http.post(url, headers: headers, body: body);
}

Future<http.Response> Login(String email, String password) {
  final url = Uri.parse('http://192.168.50.134:3000/api/login');
  final body = jsonEncode({'email': email, 'password': password});
  final headers = {'Content-Type': 'application/json'};
  return http.post(url, headers: headers, body: body);
}