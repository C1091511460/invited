import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../home/home_page.dart';
import '../profile/login_page.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final AuthRepository _authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.homegreen,
          ),
          accountName: Text("Name"),
          accountEmail: Text("Email"),
          currentAccountPicture: CircleAvatar(

          ),
          otherAccountsPictures: <Widget>[
            Icon(Icons.edit, color: Colors.white),
          ],
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('LOGIN'),
          onTap: () async {
            final ok = await _authRepository.signInWithGoogle();
            if (ok) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
