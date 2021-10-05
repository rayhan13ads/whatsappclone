import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/models/ChatModel.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chatModel;
  const ContactCard({Key? key, required this.chatModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey.shade200,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
            chatModel.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        '${chatModel.name}',
        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${chatModel.status}',
        style: GoogleFonts.openSans(fontSize: 13),
      ),
    );
  }
}
