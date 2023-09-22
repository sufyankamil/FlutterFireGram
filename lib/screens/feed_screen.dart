import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/common_appbar.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          width > webScreen ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreen
          ? null
          : CommonAppBar(
              backgroundColor: mobileBackgroundColor,
              primaryColor: Colors.blue,
              messengerButtonCallback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommentScreen(),
                  ),
                );
              },
              icon: Icons.messenger_outline_sharp,
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreen ? width * 0.3 : 0,
                vertical: width > webScreen ? 15 : 0,
              ),
              child: PostCard(snap: snapshot.data!.docs[index]),
            ),
          );
        },
      ),
    );
  }
}
