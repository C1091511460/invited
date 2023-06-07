import 'package:flutter/material.dart';
import 'package:invited_project/pages/home/home_page.dart';
import 'package:invited_project/pages/post/post_page.dart';
import 'package:invited_project/pages/mail/chat_room_page.dart';
import 'package:invited_project/widgets/BottomNavigationBar.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return PostPage();
      case 2:
        return ChatRoomPage();
      default:
        return Container();
    }
  }
}