import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/models/ChatModel.dart';

class AvaterCard extends StatelessWidget {
  final ChatModel chatModel;
  const AvaterCard({Key? key, required this.chatModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        children: [
          Stack(
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
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '${chatModel.name}',
            style:
                GoogleFonts.openSans(fontSize: 13,),
          ),
        ],
      ),
    );
  }
}
