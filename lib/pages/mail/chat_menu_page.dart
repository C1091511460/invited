import 'package:flutter/material.dart';
import 'package:invited_project/pages/mail/chat_room_page.dart';

class ChatRoomMenu extends StatelessWidget {
  final List<String> chatRooms = [
    'Chat Room 1',
    'Chat Room 2',
    'Chat Room 3',
    'Chat Room 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat menu'),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(chatRooms[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomPage(),
                ),
              );
              print('選擇了聊天室：${chatRooms[index]}');
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(ChatRoomMenu());
}