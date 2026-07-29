import 'dart:io';

import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/widget/appbar/top_appbar.dart';
import 'package:woc/widget/community/select_feeling.dart';
import 'package:woc/widget/community/widget_bottom_appbar.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => NewPostState();
}

class NewPostState extends State<NewPost> {

  TextEditingController contentController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickeImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxHeight: 1024
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("เลือกจาก Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickeImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("ถ่ายภาพ"),
              onTap: () {
                Navigator.pop(context);
                _pickeImage(ImageSource.camera);
              },
            ),
          ],
        ),
      )
    );
  }

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
          Container(),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: contentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(10,25,0,0),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLength: null,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: 15,),
                (_image != null) ? Stack(
                  children: [
                    Image.file(_image!),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ) : SizedBox()
              ],
            ),
          )
        ]
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
                  WidgetBottomAppbar(widgetIcon: Icons.add_photo_alternate_outlined, text: "ถ่ายภาพ", action: _showImageSourceActionSheet),// เปลี่ยน Object เป็น Page นั้นๆในภายหลัง
                  WidgetBottomAppbar(widgetIcon: Icons.emoji_emotions_outlined, text: "ความรู้สึก", action: () { Navigator.push(context, MaterialPageRoute( builder: (_) => const SelectFeeling()),);}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}