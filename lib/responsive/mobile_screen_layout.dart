import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  void signoutUser() async {
    AuthMethods().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signoutUser,
            icon: const Icon(Icons.exit_to_app_sharp),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Mobile"),
          ),
          ElevatedButton(
            onPressed: signoutUser,
            child: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}
