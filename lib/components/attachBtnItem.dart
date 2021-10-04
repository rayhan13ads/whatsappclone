import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttacthBtnItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color color;
  final void Function() onTap;
  const AttacthBtnItem(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.onTap,
      this.color = Colors.blueGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              iconData,
              color: Colors.white,
              size: 29,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$label",style: GoogleFonts.openSans(
              fontSize: 12
            ),),
          )
        ],
      ),
    );
  }
}
