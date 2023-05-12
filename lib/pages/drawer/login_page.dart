import 'package:flutter/material.dart';
import 'package:invited_project/pages/drawer/register_page.dart';
import 'package:invited_project/pages/home/home_page.dart';
import 'package:invited_project/widgets/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Login(_emailController, _passwordController);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  },
                  child: Text('Login'),
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


