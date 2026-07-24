import 'dart:io';

import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

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
      appBar: AppBar(leading: Icon(Icons.cancel, color: Colors.white,),),
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: WidgetColor().widgetShadow(), 
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}