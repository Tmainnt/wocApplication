import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/model/post.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/service/post_service.dart';
import 'package:woc/widget/community/create_post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: true).queryUser;
    return Scaffold(
      
      body: FutureBuilder<List<Post>>(
        future: postService.readAllPost(),
        builder: (context, snapshot) {
          final checkSnapshot = postService.checkHasData(snapshot);
          if (checkSnapshot != true) {
            return checkSnapshot;
          }

          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Center(
                child: Text("No Post.")
              );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => CreatePostCard(post: data[index - 1]),
              itemCount: data.length + 1,
            );
          }
        },
      ),
      
    );
  }
}
