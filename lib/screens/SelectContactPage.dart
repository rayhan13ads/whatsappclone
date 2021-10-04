import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectConatactPage extends StatefulWidget {
  const SelectConatactPage({Key? key}) : super(key: key);

  @override
  _SelectConatactPageState createState() => _SelectConatactPageState();
}

class _SelectConatactPageState extends State<SelectConatactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: GoogleFonts.openSans(
                  fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "256 contacts",
              style: GoogleFonts.openSans(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}
