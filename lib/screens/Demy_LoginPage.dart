import 'package:flutter/material.dart';
import 'package:whatsapp/components/ButtonCard.dart';
import 'package:whatsapp/components/ContactCard.dart';
import 'package:whatsapp/demy/demy_data.dart';
import 'package:whatsapp/screens/HomePage.dart';

class DemyLoginPage extends StatefulWidget {
  const DemyLoginPage({Key? key}) : super(key: key);

  @override
  _DemyLoginPageState createState() => _DemyLoginPageState();
}

class _DemyLoginPageState extends State<DemyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demy Login user"),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        user: chats[index],
                      ),
                    ));
              },
              child: ContactCard(chatModel: chats[index]));
        },
      ),
    );
  }
}
