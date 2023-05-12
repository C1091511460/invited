import 'package:flutter/material.dart';
import 'package:invited_project/pages/home/home_page.dart';
import 'package:invited_project/pages/mail/mail_page.dart';
import 'package:invited_project/pages/post/post_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  final List _pageList = [
    HomePage(),
    PostPage(),
    const MailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_sharp),label: "Mail"),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
