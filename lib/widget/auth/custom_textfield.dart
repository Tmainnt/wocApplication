import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class CustomTextField extends StatefulWidget {
  final String _topic;
  final bool _isObscure;
  final WidgetColor widgetColor = WidgetColor();
  final TextEditingController textEditingController = TextEditingController();
  final String _textInputType;

  CustomTextField({
    super.key,
    required String topic,
    required bool isObscure,
    required String textInputType,
  }) : _topic = topic,
       _isObscure = isObscure,
       _textInputType = textInputType;

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget._topic, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: BoxBorder.all(color: widget.widgetColor.textfieldShadow()),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: widget.widgetColor.textfieldShadow(),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  widget._isObscure ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            controller: widget.textEditingController,
            keyboardType: widget._textInputType == "email"
                ? TextInputType.emailAddress
                : widget._textInputType == "number"
                ? TextInputType.number
                : TextInputType.text,
          ),
        ),
      ],
    );
  }
}
