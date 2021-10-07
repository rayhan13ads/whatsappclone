import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherStatus extends StatelessWidget {
  final String name;
  final String time;
  final String imageName;
  const OtherStatus(
      {Key? key,
      required this.imageName,
      required this.name,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage("$imageName"),
      ),
      title: Text(
        "$name",
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "Today at, $time ",
        style: GoogleFonts.openSans(fontSize: 13, color: Colors.grey.shade900),
      ),
    );
  }
}
