import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/widgets/common_appbar.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  final snap;
  const FeedScreen({super.key, this.snap});

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
              messengerButtonCallback: () {},
              icon: Icons.messenger_outline_sharp,
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          
            return Center(
              child: Shimmer.fromColors(
                period: const Duration(
                    seconds:
                        5), // Control the duration of the shimmer animation
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[900],
                  ),
                ),
              ),
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
