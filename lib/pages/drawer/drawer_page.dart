import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invited_project/pages/drawer/login_page.dart';

import '../../utils/colors.dart';
import '../../widgets/securestorage.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';
  final secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await secureStorage.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      if (isLoggedIn) {
        readUserData();
      }
    });
  }

  Future<void> readUserData() async {
    final userData = await secureStorage.readUserData();
    if (userData != null) {
      setState(() {
        _userName = userData['name'] ?? '';
        _userEmail = userData['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (_isLoggedIn)
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              // Add your decoration here
            ),
            accountName: Text(_userName, style: TextStyle(color: AppColors.SmallText)),
            accountEmail: Text(_userEmail, style: TextStyle(color: AppColors.SmallText)),
            currentAccountPicture: CircleAvatar(
              // Add your current account picture here
            ),
            otherAccountsPictures: <Widget>[
              Icon(Icons.edit, color: AppColors.SmallText),
            ],
          ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(_isLoggedIn ? 'LOGOUT' : 'LOGIN'),
          onTap: () async {
            if (_isLoggedIn) {
              // Perform logout operation
              await secureStorage.deleteToken();
              await secureStorage.deleteUserData();
              setState(() {
                _isLoggedIn = false;
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ).then((_) {
                // Refresh the login status after returning from the login page
                checkLoginStatus();
              });
            }
          },
        ),
      ],
    );
  }
}
