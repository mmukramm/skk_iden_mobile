import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          child: const Text("Submit"),
          onPressed: () async {
            await FirebaseMessaging.instance
                .subscribeToTopic("onTap")
                .whenComplete(
              () {
                debugPrint("Reeeeesss");
                debugPrint("Reeeeesss");
              },
            );
          },
        ),
      ),
    );
  }
}
