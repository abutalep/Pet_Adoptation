import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hopepaw/features/chat/Data/firebase/chat_services.dart';
import 'package:hopepaw/features/chat/Data/models/app_user.dart';
import 'package:hopepaw/features/chat/UI/screens/chat_screen.dart';
import 'package:hopepaw/features/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  static const Color _darkPurple = Color(0xFF44174E);
  static const Color _purpleColor = Color(0xFF7B61FF);
  Future<void> handleNotification() async {
    final remotemessage = await FirebaseMessaging.instance.getInitialMessage();

    if (remotemessage != null) {
      handleMessage(remotemessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((value) {
      handleMessage(value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleNotification();
  }

  void handleMessage(RemoteMessage message) {
    final notification = message.notification;
    final userId = notification?.body;
    final email = notification?.title;
    if (userId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            user: UserModel(id: userId, email: email ?? ''),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final displayName =
        userProvider.userData?['displayName'] ??
        FirebaseAuth.instance.currentUser?.displayName ??
        "User";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _darkPurple,
        title: Text(
          "Chats - ${displayName}",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: ChatServices.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("empty , add some chats"));
          }
          final users = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(user: user),
                      ),
                    );
                  },
                leading: CircleAvatar(
                  backgroundColor: _purpleColor,
                  child: Text(
                    user.email!.isNotEmpty ? user.email![0].toUpperCase() : '?',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  user.email!.split("@")[0],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  user.email!,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              );
            },
          );
        },
      ),
    );
  }
}
