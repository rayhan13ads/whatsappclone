import 'package:flutter/cupertino.dart';

class ChatModel {
  String? name;
  IconData? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  ChatModel({this.currentMessage,this.icon,this.isGroup,this.name,this.time});
}
