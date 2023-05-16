import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invited_project/pages/drawer/preference_page.dart';
import 'package:invited_project/pages/drawer/register_page.dart';
import 'package:invited_project/widgets/api.dart';

import '../../tabs.dart';
import '../../widgets/securestorage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  API api = API();
  final _formKey = GlobalKey<FormState>();
  late String _emailController;
  late String _passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailController = value!;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passwordController = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      api.login(_emailController, _passwordController).then((response) async {
                        if (response.statusCode == 200) {
                          final Map<String, dynamic> data = json.decode(response.body);
                          final auth_token = data['auth_token'];
                          final secureStorage = SecureStorage();
                          secureStorage.saveToken(auth_token);
                          Map<String, dynamic>? userData = await api.fetchUserData(_emailController);

                          if (userData != null) {
                            await secureStorage.saveUserData(userData);
                            final firstLogin = userData['first_login'] == 1;
                            if (firstLogin) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => PreferenceFormPage()),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Tabs()),
                              );
                            }
                          } else {
                            // 处理获取用户数据失败的情况
                            print('无法获取用户数据');
                          }
                        } else if (response.statusCode == 401) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid email or password'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Server Error'),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Text('登入'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Don\'t have an account? Register here.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


