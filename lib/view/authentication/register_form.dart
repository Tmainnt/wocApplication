import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/view/authentication/login_form.dart';
import 'package:woc/widget/auth/custom_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();
  List<String> gender = ["ชาย", "หญิง", "อื่นๆ"];
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext contexct) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/login_bg.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 40, 25, 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "สมัคร",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "สมาชิก",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                topic: "อีเมล",
                                isObscure: false,
                                textInputType: "",
                              ),
                              CustomTextField(
                                topic: "รหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                              ),
                              CustomTextField(
                                topic: "ยืนยันรหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                              ),
                              CustomTextField(
                                topic: "ชื่อ",
                                isObscure: true,
                                textInputType: "",
                              ),
                              CustomTextField(
                                topic: "นามสกุล",
                                isObscure: true,
                                textInputType: "",
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "เพศ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: widgetColor.widgetShadow(),
                                              offset: Offset(1, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: DropdownMenu(
                                          inputDecorationTheme:
                                              InputDecorationTheme(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                          menuStyle: MenuStyle(
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                  widgetColor.widgetShadow(),
                                                ),
                                            elevation: WidgetStateProperty.all(
                                              8,
                                            ),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                          onSelected: (value) {
                                            setState(() {});
                                          },
                                          controller: genderController,
                                          hintText: "เลือก",
                                          dropdownMenuEntries:
                                              <DropdownMenuEntry<String>>[
                                                DropdownMenuEntry(
                                                  value: "ชาย",
                                                  label: "ชาย",
                                                ),
                                                DropdownMenuEntry(
                                                  value: "หญิง",
                                                  label: "หญิง",
                                                ),
                                                DropdownMenuEntry(
                                                  value: "อื่นๆ",
                                                  label: "อื่นๆ",
                                                ),
                                              ],
                                        ),
                                      ),

                                      ?genderController.text.isNotEmpty
                                          ? IconButton(
                                              onPressed: () {
                                                genderController.clear();
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.cancel),
                                              color: widgetColor.cancel(),
                                            )
                                          : null,
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        print("Click button");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widgetColor.elevatedButtonAuth(),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "สมัครสมาชิก",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "เป็นสมาชิกแล้ว? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "เข้าสู่ระบบ",
                            style: TextStyle(
                              color: textColor.highlightTextAuth(),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginForm(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
