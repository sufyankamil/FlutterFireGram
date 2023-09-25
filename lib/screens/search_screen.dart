import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import 'profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  String? _validateSearchText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a search query';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search a user ',
              hintText: 'Search a user',
              border: OutlineInputBorder(),
            ),
            validator: _validateSearchText,
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: _searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Shimmer.fromColors(
                        period: const Duration(
                            seconds:
                                2), // Control the duration of the shimmer animation
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl'],
                            ),
                            radius: 16,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datePublished')
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  return MasonryGridView.count(
                    crossAxisCount: 3,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) => Image.network(
                      (snapshot.data! as dynamic).docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    ),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  );
                },
              ),
      ),
    );
  }
}
