import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // function to upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occurred";
    try {
      String photoURL =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1(); // creates unique id based on time

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoURL,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Like posts
  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred while trying to like a post";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic, List commentsLiked) async {
    String res = "Error occurred while posting comment";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'postId': postId,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'commentsLiked': [],
        });
        res = 'success';
      } else {
        res = "Please enter text before posting";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Like posts
  Future<String> likeComment(String postId, String uid, List likes, String commentId,) async {
    String res = "Some error occurred while trying to like a comment";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
             .doc(commentId)
            .update({
          'commentsLiked': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
         _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
             .doc(commentId)
            .update({
          'commentsLiked': FieldValue.arrayUnion([uid])
        // _firestore.collection('posts').doc(postId).update({
        //   'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
