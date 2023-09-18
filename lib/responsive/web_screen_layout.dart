import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

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
      body: const Center(
        child: Text("Web"),
      ),
    );
  }
}
