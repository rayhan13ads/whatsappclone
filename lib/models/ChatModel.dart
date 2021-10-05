import 'package:flutter/cupertino.dart';

class ChatModel {
  String? name;
  IconData? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select;
  ChatModel(
      {this.currentMessage,
      this.status,
      this.icon,
      this.isGroup,
      this.name,
      this.time,
      this.select = false
      });
}
