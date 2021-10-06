import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whatsapp/components/OwnMassageCard.dart';
import 'package:whatsapp/components/ReplayMassageCard.dart';
import 'package:whatsapp/components/attachBtnItem.dart';
import 'package:whatsapp/models/ChatModel.dart';
import 'package:whatsapp/models/MessageModel.dart';
import 'package:whatsapp/screens/SelectContactPage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChatPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel user;
  const IndividualChatPage(
      {Key? key, required this.chatModel, required this.user})
      : super(key: key);

  @override
  _IndividualChatPageState createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  bool show = false;
  bool isSendBtn = false;
  late IO.Socket socket;

  final foucusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    foucusNode.addListener(() {
      if (foucusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io(
        'http://192.168.0.229:5000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection // optional
            .build());
    socket.connect();
    socket.emit('signIn', widget.user.id);
    socket.onConnect((data) {
      print("------------Connected");
      socket.on("message", (data) {
        print(data);
        setMessage(MessageModel(message: data["message"], type: "received"));
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    });
    print("------------${socket.connected}");
  }

  void sendMessage({String? message, int? userId, int? targetId}) {
    setMessage(MessageModel(
        message: message,
        type: "send",
        time: DateTime.now().toString().substring(10, 16)));
    socket.emit(
        "message", {"message": message, "user": userId, "target": targetId});
    _controller.clear();
  }

  void setMessage(MessageModel messageModel) {
    setState(() {
      messages.add(messageModel);
    });
  }

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/whatsapp_Back.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      widget.chatModel.icon,
                      size: 16,
                    ),
                  )
                ],
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatModel.name!,
                  style: GoogleFonts.openSans(
                      fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                Text(
                  "last seen today at ${widget.chatModel.time}",
                  style: GoogleFonts.openSans(fontSize: 13),
                )
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("New Contact"),
                      value: "New Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs",
                    ),
                    PopupMenuItem(
                      child: Text("Whatsapp Web"),
                      value: "Whatsapp Web",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                  ];
                },
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    //  height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (messages.length == 1) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "send") {
                          return OwnMessageCard(
                            messageModel: messages[index],
                          );
                        } else {
                          return ReplayMassageCard(
                            messageModel: messages[index],
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: foucusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(Icons.emoji_emotions),
                                          onPressed: () {
                                            foucusNode.unfocus();
                                            foucusNode.canRequestFocus = false;
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(5),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) {
                                                        return bottomsheet();
                                                      });
                                                },
                                                icon: Icon(Icons.attach_file)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.camera_alt)),
                                          ],
                                        ),
                                      ),
                                      onChanged: (v) {
                                        if (v.length > 0) {
                                          setState(() {
                                            isSendBtn = true;
                                          });
                                        } else {
                                          setState(() {
                                            isSendBtn = false;
                                          });
                                        }
                                      },
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 2,
                                  bottom: 8,
                                  right: 2,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFF128C7E),
                                  radius: 25,
                                  child: IconButton(
                                      onPressed: () {
                                        if (isSendBtn) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeInOut);
                                          sendMessage(
                                              message: _controller.text,
                                              targetId: widget.chatModel.id,
                                              userId: widget.user.id);
                                          setState(() {
                                            isSendBtn = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        isSendBtn ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          emojiSelect()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  emojiSelect() {
    return Offstage(
      offstage: !show,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              _onEmojiSelected(emoji);
            },
            onBackspacePressed: _onBackspacePressed,
            config: Config(
                columns: 7,
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                progressIndicatorColor: Colors.blue,
                backspaceColor: Colors.blue,
                showRecentsTab: true,
                recentsLimit: 28,
                noRecentsText: 'No Recents',
                noRecentsStyle:
                    const TextStyle(fontSize: 20, color: Colors.black26),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL)),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 290,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AttacthBtnItem(
                    iconData: Icons.insert_drive_file,
                    label: "Document",
                    onTap: () {},
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  AttacthBtnItem(
                    iconData: Icons.camera_alt,
                    label: "Camera",
                    onTap: () {},
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  AttacthBtnItem(
                    iconData: Icons.insert_photo,
                    label: "Gallery",
                    onTap: () {},
                    color: Colors.purple,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AttacthBtnItem(
                    iconData: Icons.headset,
                    label: "Audio",
                    onTap: () {},
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  AttacthBtnItem(
                    iconData: Icons.location_pin,
                    label: "Location",
                    onTap: () {},
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  AttacthBtnItem(
                    iconData: Icons.person,
                    label: "Contact",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectConatactPage(),
                          ));
                    },
                    color: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
