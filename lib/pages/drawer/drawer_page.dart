import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invited_project/pages/drawer/login_page.dart';

import '../../utils/colors.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(

          ),
          accountName: Text("Name",style: TextStyle(color: AppColors.SmallText),),
          accountEmail: Text("Email",style: TextStyle(color: AppColors.SmallText),),
          currentAccountPicture: CircleAvatar(

          ),
          otherAccountsPictures: <Widget>[
            Icon(Icons.edit, color: AppColors.SmallText),
          ],
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('LOGIN'),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }
}
