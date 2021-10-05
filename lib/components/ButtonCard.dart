import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/models/ChatModel.dart';

class ButtonCard extends StatelessWidget {
  final String name;
  final IconData iconData;
  const ButtonCard({Key? key, required this.name, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: Color(0xFF25D366),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        '$name',
        style:
            GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold),
      ),
     
    );
  }
}
