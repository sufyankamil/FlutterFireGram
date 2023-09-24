import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../providers/user_providers.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String comment = '';

  @override
  void dispose() {
    super.dispose();
    commentEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    bool isDataEmpty(
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      return !snapshot.hasData || snapshot.data!.docs.isEmpty;
    }

    void postComment(String uid, String name, String profilePic) async {
      try {
        String res = await FireStoreMethods().postComment(
          widget.snap['postId'],
          commentEditingController.text,
          uid,
          user.username,
          user.photoUrl,
          [],
        );

        if (res != 'success') {
          if (context.mounted) {
            Fluttertoast.showToast(
              msg: res,
              backgroundColor: Colors.red,
            );
          }
        } else {
          if (context.mounted) {
            Fluttertoast.showToast(
              msg: 'Comment was successfully posted',
              backgroundColor: Colors.green,
            );
          }
        }
        setState(() {
          commentEditingController.text = "";
        });
      } catch (err) {
        Fluttertoast.showToast(
            msg: err.toString(), backgroundColor: Colors.red);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Text(user.username),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          // Check if the data is empty
          if (isDataEmpty(snapshot)) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: const Center(child: Text('You don\'t have any comments.')),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => CommentCard(
                snap: snapshot.data!.docs[index],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
          child: Form(
        key: _formKey,
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                user.photoUrl,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextFormField(
                  controller: commentEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter comment here',
                    labelText: 'Comment as ${user.username}',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    comment = value!;
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, save the comment
                  _formKey.currentState!.save();
                  postComment(
                    user.uid,
                    user.photoUrl,
                    user.username,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }
}
