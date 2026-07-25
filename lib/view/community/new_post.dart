import 'dart:io';

import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/widget/appbar/top_appbar.dart';
import 'package:woc/widget/community/widget_bottom_appbar.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => NewPostState();
}

class NewPostState extends State<NewPost> {

  late File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppbar(
        centerText: '', 
        leadingContent: Icon(Icons.cancel), 
        trailingContent: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(3)
          ),
          width: 30, // random width will replace soon!
          height: 30, // random height will replace soon!
          child: Center(
            child: Text("บันทึก", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(),
          Image.file(image)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 110,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: WidgetColor().widgetShadow(), 
                blurRadius: 4, 
                offset: Offset(0, 0)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetBottomAppbar(widgetIcon: Icons.camera_alt, text: "ถ่ายภาพ", page: Object()),
                  WidgetBottomAppbar(widgetIcon: Icons.add_photo_alternate_outlined, text: "เพิ่มรูปภาพ", page: Object()), // เปลี่ยน Object เป็น Page นั้นๆในภายหลัง
                  WidgetBottomAppbar(widgetIcon: Icons.emoji_emotions_outlined, text: "ความรู้สึก", page: Object()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}