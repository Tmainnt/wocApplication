import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class TopNavbar extends StatefulWidget implements PreferredSizeWidget {
  final dynamic centerText;
  final dynamic leadingContent;
  final dynamic trailingContent;

  const TopNavbar({
    super.key,
    required this.centerText,
    required this.leadingContent,
    required this.trailingContent,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<TopNavbar> createState() => TopNavbarState();
}

class TopNavbarState extends State<TopNavbar> {
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
