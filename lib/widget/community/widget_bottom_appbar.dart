import 'package:flutter/material.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';

class WidgetBottomAppbar extends StatelessWidget {
  
  IconData widgetIcon;
  String text;
  dynamic page;

  WidgetBottomAppbar({super.key, required this.widgetIcon, required this.text, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: WidgetColor().widgetShadow(),
              blurRadius: 5,
              offset: Offset(0,0),
            ),
          ],
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(widgetIcon, size: 40,),
            Text(text, style: TextStyle(
              color: TextColor().subText(),
              fontSize: 10,
            ),)
          ],
        ),
      ),
    );
  }
}