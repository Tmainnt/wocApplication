import 'package:flutter/material.dart';
import 'package:woc/view/community/post_page.dart';
import 'package:woc/widget/navbar/top_navbar.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();

  @override
  Widget build(BuildContext context) {
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.web,
                            size: 25,
                            color: widgetColor.iconWithBlackBackground(),
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Post",
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
        trailingContent: null,
      ),
      body: Center(child: Text("This is Home Page!")),
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
