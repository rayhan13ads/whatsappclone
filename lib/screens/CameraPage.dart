import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/screens/CamerarViewPage.dart';
import 'package:whatsapp/screens/VideoView.dart';

List<CameraDescription>? cameras;

class CamraPage extends StatefulWidget {
  const CamraPage({Key? key}) : super(key: key);

  @override
  _CamraPageState createState() => _CamraPageState();
}

class _CamraPageState extends State<CamraPage> {
  late CameraController _cameraController;

  late Future<void> cameraValue;
  bool isRecoard = false;
  bool isFlash = false;
  bool isCameraFont = true;
  double transform = pi;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_cameraController),
                );

                // return Transform.scale(
                //   scale:  _cameraController.value.aspectRatio/deviceRatio,
                //   child: AspectRatio(aspectRatio:_cameraController.value.aspectRatio,
                //   child: CameraPreview(_cameraController),
                //   )
                // );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFlash = !isFlash;
                            });
                            isFlash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: Icon(
                            isFlash ? Icons.flash_on : Icons.flash_off,
                            size: 28,
                            color: Colors.white,
                          )),
                      GestureDetector(
                          onLongPress: () {
                            setState(() {
                              isRecoard = true;
                            });
                            takeVideo(context);
                          },
                          onLongPressUp: () async {
                            await _cameraController
                                .stopVideoRecording()
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoViewPage(
                                      path: value.path,
                                    ),
                                  ));
                            });
                            setState(() {
                              isRecoard = false;
                            });
                          },
                          onTap: () {
                            if (!isRecoard) {
                              takePhoto(context);
                            }
                          },
                          child: isRecoard
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  size: 70,
                                  color: Colors.white,
                                )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isCameraFont = !isCameraFont;
                              transform = transform + pi;
                            });

                            int cameraPostion = isCameraFont ? 0 : 1;
                            _cameraController = CameraController(
                                cameras![cameraPostion], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          },
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              size: 28,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for Video, tap for photo",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");

    await _cameraController.takePicture().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraViewPage(
              path: value.path,
            ),
          ));
    });
  }

  void takeVideo(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");

    await _cameraController.startVideoRecording();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }
}
