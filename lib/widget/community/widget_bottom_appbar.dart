import 'package:flutter/material.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';

class WidgetBottomAppbar extends StatelessWidget {
  
  final IconData widgetIcon;
  final String text;
  final VoidCallback action;

  const WidgetBottomAppbar({super.key, required this.widgetIcon, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action;
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