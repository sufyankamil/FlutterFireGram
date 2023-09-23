import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  final String uid;
  final String username;
  final commentsLiked;
  final DateTime datePublished;
  final String text;
  final String commentId;
  final String profImage;

  const Comments(
      {required this.uid,
      required this.username,
      required this.commentsLiked,
      required this.commentId,
      required this.datePublished,
      required this.text,
      required this.profImage,
      });

  static Comments fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comments(
      uid: snapshot["uid"],
      commentsLiked: snapshot["commentsLiked"],
      commentId: snapshot["commentId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      text: snapshot['text'],
      profImage: snapshot['profImage']
    );
  }

   Map<String, dynamic> toJson() => {
        "uid": uid,
        "commentsLiked": commentsLiked,
        "username": username,
        "commentId": commentId,
        "datePublished": datePublished,
        'text': text,
        'profImage': profImage
      };
}