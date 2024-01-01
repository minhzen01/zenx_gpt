enum MessageType { user, bot }

class Message {
  String msg;
  final MessageType msgType;
  bool complete = false;
  int dateTime;

  Message({
    required this.msg,
    required this.msgType,
    this.complete = false,
    int? dateTime,
  }) : dateTime = dateTime ?? DateTime.now().millisecondsSinceEpoch;
}
