import 'dart:io';

import 'package:flutter/material.dart';

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
      body: Container(
        child: Column(
          children: [
            TextField(),
            Image.file(image),
          ],
        ),
      ),
    );
  }
}