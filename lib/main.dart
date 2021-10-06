import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/screens/CameraPage.dart';
import 'package:whatsapp/screens/Demy_LoginPage.dart';
import 'package:whatsapp/screens/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF075E54), accentColor: Color(0xFF128C7E)),
      home: DemyLoginPage() //HomePage(),
    );
  }
}
