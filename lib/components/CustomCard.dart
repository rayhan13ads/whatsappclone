import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/models/ChatModel.dart';
import 'package:whatsapp/screens/IndividualCahtPage.dart';

class CoustomCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel user;
  const CoustomCard({Key? key, required this.chatModel, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualChatPage(
                chatModel: chatModel,
                user: user,
              ),
            ));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(
                chatModel.icon,
                color: Colors.white,
                size: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              "${chatModel.name}",
              style: GoogleFonts.openSans(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "${chatModel.currentMessage}",
                  style: GoogleFonts.openSans(fontSize: 13),
                ),
              ],
            ),
            trailing: Text("${chatModel.time}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 20),
            child: Divider(
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
