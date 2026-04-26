import 'package:flutter/material.dart';
import 'package:woc/theme/widget_color.dart';

class CustomTextField extends StatefulWidget {
  final String _topic;
  final bool isObscure;
  final String textInputType;

  CustomTextField({
    super.key,
    required String topic,
    required this.isObscure,
    required this.textInputType,
  }) : _topic = topic;

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController textEditingController = TextEditingController();
  final WidgetColor widgetColor = WidgetColor();

  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget._topic, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.only(left: 7, right: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: widgetColor.textfieldShadow(),
                offset: Offset(1, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            obscureText: isObscure,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: textEditingController.text.isEmpty
                  ? null
                  : widget._topic == "รหัสผ่าน" ||
                        widget._topic == "ยืนยันรหัสผ่าน"
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
            ),
            controller: textEditingController,
            onChanged: (value) => setState(() {}),
            keyboardType: widget.textInputType == "email"
                ? TextInputType.emailAddress
                : widget.textInputType == "number"
                ? TextInputType.number
                : TextInputType.text,
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
