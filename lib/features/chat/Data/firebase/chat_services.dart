import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hopepaw/features/auth/Data/firebase/auth_service.dart';
import 'package:hopepaw/features/chat/Data/models/app_user.dart';
import 'package:hopepaw/features/chat/Data/models/message.dart';

class ChatServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> sendMessage(Message message) async {
    final messageDoc = _db.collection("messages").doc();
    message.id = messageDoc.id;
    await messageDoc.set(message.toMap());
  }

  static Stream<List<Message>> getMessages({
    required String receiverId,
    required String senderId,
  }) {
    return _db
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Message.fromMap(doc.data()))
              .where(
                (msg) =>
                    (msg.senderId == senderId &&
                        msg.receiverId == receiverId) ||
                    (msg.senderId == receiverId && msg.receiverId == senderId),
              )
              .toList();
        });
  }

  static Stream<List<UserModel>> getUsers() {
    final queryStream = _db
        .collection('users')
        .where('id', isNotEqualTo: AuthService.getCurrentUserId())
        .snapshots();
    return queryStream.map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }
}
