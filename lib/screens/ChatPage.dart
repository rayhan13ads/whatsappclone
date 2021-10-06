import 'package:flutter/material.dart';
import 'package:whatsapp/components/CustomCard.dart';

import 'package:whatsapp/models/ChatModel.dart';

class ChatPage extends StatefulWidget {
  final ChatModel user;
  final List<ChatModel> chats;
  const ChatPage({Key? key, required this.user, required this.chats}) : super(key: key);

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
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          return CoustomCard(
            user: widget.user,
            chatModel: widget.chats[index],
          );
        },
      ),
    );
  }
}
