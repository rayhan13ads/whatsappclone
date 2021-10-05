import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/components/ButtonCard.dart';
import 'package:whatsapp/components/ContactCard.dart';
import 'package:whatsapp/demy/demy_data.dart';
import 'package:whatsapp/screens/CreateGroupPage.dart';

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
        body: ListView.builder(
          itemCount: chats.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroupPage(),
                      ));
                },
                child: ButtonCard(
                  name: "New Group",
                  iconData: Icons.group_add,
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                name: "New Contact",
                iconData: Icons.person_add,
              );
              ;
            }
            return ContactCard(chatModel: chats[index - 2]);
          },
        ));
  }
}
