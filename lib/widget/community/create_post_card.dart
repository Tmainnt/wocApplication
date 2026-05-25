import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/model/post.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/util/time_format.dart';

class CreatePostCard extends StatefulWidget {
  final Post post;
  const CreatePostCard({super.key, required this.post});

  @override
  State<CreatePostCard> createState() => CreatePostCardState();
}

class CreatePostCardState extends State<CreatePostCard> {
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).queryUser;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widgetColor.widgetShadow(),
            offset: Offset(0, 0),
            blurRadius: 5,
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        children: [
          // Profile image, username, publish time, follow button and more icon (write my programmer naja not AI)
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: user!.profileImage.isNotEmpty
                        ? NetworkImage(user.profileImage)
                        : AssetImage('assets/image/profileImage.png'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(user.name),
                      Text(convertTimestamp(widget.post.createTimestamp)),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(), // make follow button here, check in database that this user has already follow this post owner yet?
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz), // เดี๋ยวมาเพิ่ม action
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          widget.post.content.isNotEmpty
              ? Text(widget.post.content, maxLines: 0)
              : SizedBox(),
          widget.post.image.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(),
                    );
                  },
                  child: Image.network(widget.post.image),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
