import 'package:flutter/material.dart';
import 'package:whatsapp/components/CustomCard.dart';
import 'package:whatsapp/demy/demy_data.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CoustomCard(chatModel: chats[index],);
        },
      ),
    );
  }
}
