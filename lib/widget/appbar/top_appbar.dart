import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class TopAppbar extends StatefulWidget implements PreferredSizeWidget {
  final dynamic centerText;
  final dynamic leadingContent;
  final dynamic trailingContent;

  const TopAppbar({
    super.key,
    required this.centerText,
    required this.leadingContent,
    required this.trailingContent,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<TopAppbar> createState() => TopAppbarState();
}

class TopAppbarState extends State<TopAppbar> {
  final widgetColor = WidgetColor();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: widgetColor.topNavbar()),
        ),
      ),
      title: widget.centerText,
      foregroundColor: Colors.white,
      centerTitle: true,
      leading: widget.leadingContent,
      actions: [widget.trailingContent],
    );
  }
}
