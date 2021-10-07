import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/balram.jpg"),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.greenAccent.shade700,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ))
        ],
      ),
      title: Text(
        "My Status",
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "Tap to add status update",
        style: GoogleFonts.openSans(fontSize: 13, color: Colors.grey.shade900),
      ),
    );
  }
}
