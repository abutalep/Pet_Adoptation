import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String text;
  Timestamp timestamp;
  String senderId;
  String receiverId;

  Message({
    this.id,
    required this.text,
    required this.timestamp,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'timestamp': timestamp,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'],
      timestamp: map['timestamp']  as Timestamp,
      senderId: map['senderId'],
      receiverId: map['receiverId'],
    );
  }

}
