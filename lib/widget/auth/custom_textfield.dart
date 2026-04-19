import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class CustomTextField extends StatefulWidget {
  final String _topic;
  bool _isObscure;
  final WidgetColor widgetColor = WidgetColor();
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
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget._topic, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.only(left: 3, right: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(color: widget.widgetColor.textfieldShadow()),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: widget.widgetColor.textfieldShadow(),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            obscureText: widget._isObscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: textEditingController.text.isEmpty
                  ? null
                  : widget._topic == "รหัสผ่าน" ||
                        widget._topic == "ยืนยันรหัสผ่าน"
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget._isObscure = !widget._isObscure;
                        });
                      },
                      icon: Icon(
                        widget._isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : null,
            ),
            controller: textEditingController,
            onChanged: (value) => setState(() {}),
            keyboardType: widget._textInputType == "email"
                ? TextInputType.emailAddress
                : widget._textInputType == "number"
                ? TextInputType.number
                : TextInputType.text,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
