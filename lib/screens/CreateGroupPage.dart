import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/components/AvaterCard.dart';
import 'package:whatsapp/components/ButtonCard.dart';
import 'package:whatsapp/components/ContactCard.dart';
import 'package:whatsapp/demy/demy_data.dart';
import 'package:whatsapp/models/ChatModel.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: GoogleFonts.openSans(
                    fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                "Add participants",
                style: GoogleFonts.openSans(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: chats.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    height: groups.length > 0 ? 90 : 10,
                  );
                }
                return InkWell(
                    onTap: () {
                      setState(() {
                        if (chats[index - 1].select == true) {
                          groups.remove(chats[index - 1]);
                          chats[index - 1].select = false;
                        } else {
                          groups.add(chats[index - 1]);
                          chats[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(chatModel: chats[index - 1]));
              },
            ),
            groups.length > 0
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            if (chats[index].select == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      groups.remove(chats[index]);
                                      chats[index].select = false;
                                    });
                                  },
                                  child: AvaterCard(chatModel: chats[index]));
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  )
                : Container()
          ],
        ));
  }
}
