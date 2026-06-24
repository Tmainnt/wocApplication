import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:woc/model/post.dart';
import 'package:woc/model/user.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/service/post_service.dart';
import 'package:woc/view/authentication/login_form.dart';
import 'package:woc/view/community/chat_page.dart';
import 'package:woc/widget/community/create_post_card.dart';
import 'package:woc/widget/navbar/bottom_navbar.dart';
import 'package:woc/widget/navbar/top_navbar.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    User? userData = Provider.of<UserProvider>(context, listen: true).queryUser;
    return Scaffold(
      appBar: TopNavbar(
        centerText: centerTextCreate(),
        leadingContent: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: Colors.black87,
              builder: (context) {
                return ListView(
                  padding: EdgeInsets.only(left: 10, top: 60),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home,
                            size: 25,
                            color: widgetColor.iconWithBlackBackground(),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 15,
                              color: textColor.subText(),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<UserProvider>(context).clearUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginForm()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 25,
                            color: widgetColor.iconWithBlackBackground(),
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15,
                              color: textColor.subText(),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.cancel,
                            size: 25,
                            color: widgetColor.iconWithBlackBackground(),
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              color: textColor.subText(),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.menu),
        ),
        trailingContent: IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Post>>(
        future: postService.readAllPost(),
        builder: (context, snapshot) {
          final checkSnapshot = postService.checkHasData(snapshot);
          if (checkSnapshot.runtimeType != Bool) {
            return checkSnapshot;
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) => CreatePostCard(post: data[index]),
            itemCount: data.length + 1,
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(
        index: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      )
    );
  }

  Widget centerTextCreate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Workout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        Text(
          "& Community",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
