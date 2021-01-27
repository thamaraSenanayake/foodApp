import 'package:food_app/model/message.dart';

class MessageHeader{
  String headName;
  String user1;
  String user2;
  DateTime user1LastRead;
  DateTime user2LastRead;
  int msgCount;
  List<SingleMessage> msgList;
}