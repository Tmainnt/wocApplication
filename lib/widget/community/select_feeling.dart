import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/model/post.dart';

class SelectFeeling extends StatefulWidget {

  final Post post;
  const SelectFeeling({super.key, required this.post});

  @override
  State<SelectFeeling> createState() => SelectFeelingState();
}

class SelectFeelingState extends State<SelectFeeling> {
  @override
  Widget build(BuildContext context ) {
    final user = Provider.of<UserProvider>(context, listen: true).queryUser;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: WidgetColor().widgetShadow(),
                blurRadius: 3,
                offset: Offset(1, 2)
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: Image.network(user!.profileImage) as ImageProvider,
              )
            ],
          ),
        ),
        Container(),
      ],
    );
  }
}