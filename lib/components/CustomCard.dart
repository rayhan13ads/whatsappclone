import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CoustomCard extends StatelessWidget {
  const CoustomCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Icon(Elusive.group,color: Colors.white,size: 36,),
        backgroundColor: Colors.blueGrey,
      ),
      title: Text("Dev Stack",style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),),
      subtitle: Row(
        children: [
          Icon(Icons.done_all),
          SizedBox(width: 3,),
          Text("hi Dev", style: GoogleFonts.openSans(
            fontSize: 13
          ),),
        ],
      ),
      trailing: Text("18:4"),
    );
  }
}