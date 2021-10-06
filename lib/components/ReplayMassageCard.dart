import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/models/MessageModel.dart';

class ReplayMassageCard extends StatelessWidget {
  final MessageModel? messageModel;
  const ReplayMassageCard({Key? key, this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          // color: Color(0xFFdcf8c6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 20, right: 60),
                child: Text(
                  messageModel!.message!,
                  style: GoogleFonts.openSans(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      "20:58",
                      style: GoogleFonts.openSans(
                          fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
