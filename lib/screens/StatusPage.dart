import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/components/status/HeadOwnStatus.dart';
import 'package:whatsapp/components/status/OtherStatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey.shade900,
              ),
              backgroundColor: Colors.blueGrey.shade100,
            ),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent.shade700,
            elevation: 5,
            child: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeadOwnStatus(),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text(
                  "Recent updates",
                  style: GoogleFonts.openSans(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            OtherStatus(
              imageName: "assets/images/1.jpg",
              name: "Rasel",
              time: "01:27",
            ),
            OtherStatus(
              imageName: "assets/images/2.jpg",
              name: "Rasel",
              time: "01:27",
            ),
            OtherStatus(
              imageName: "assets/images/3.jpg",
              name: "Rasel",
              time: "01:27",
            ),
            SizedBox(height: 10,),
            Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade300,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: Text(
                  "Viewed updates",
                  style: GoogleFonts.openSans(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            OtherStatus(
              imageName: "assets/images/1.jpg",
              name: "Rasel",
              time: "01:27",
            ),
            OtherStatus(
              imageName: "assets/images/2.jpg",
              name: "Rasel",
              time: "01:27",
            ),
            OtherStatus(
              imageName: "assets/images/3.jpg",
              name: "Rasel",
              time: "01:27",
            ),
          ],
        ),
      ),
    );
  }
}
