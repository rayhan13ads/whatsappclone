import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  final String path;
  const VideoViewPage({Key? key, required this.path}) : super(key: key);

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.file(File(widget.path))
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.crop_rotate,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.title,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 27,
              )),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                  : Container(),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Caption....",
                        prefixIcon: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: 17,
                        ),
                        hintStyle: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 27),
                        suffixIcon: CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.teal.shade700,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 27,
                          ),
                        )),
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 17),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
