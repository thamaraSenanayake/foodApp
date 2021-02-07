import 'package:food_app/model/message.dart';

class MessageHeader{
  String headName;
  String user1;
  String user2;
  String user1name;
  String user2name;
  String user1ImgUrl;
  String user2ImgUrl;
  DateTime user1LastRead;
  DateTime user2LastRead;
  int msgCount;
  List<SingleMessage> msgList;
}