import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreen = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  Text('Search'),
  const AddPost(),
];
