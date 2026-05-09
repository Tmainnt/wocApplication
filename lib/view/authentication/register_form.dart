import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:woc/service/auth_service.dart';
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
  bool isLoading = false;
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();
  String? selectedGender;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  bool clickDob = false;

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
                                textInputType: "email",
                                textEditingController: emailController,
                              ),
                              CustomTextField(
                                topic: "ชื่อผู้ใช้งาน",
                                isObscure: false,
                                textInputType: "",
                                textEditingController: nameController,
                              ),
                              CustomTextField(
                                topic: "รหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                                textEditingController: passwordController,
                              ),
                              CustomTextField(
                                topic: "ยืนยันรหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                                textEditingController:
                                    confirmPasswordController,
                              ),
                              CustomTextField(
                                topic: "เบอร์โทรศัพท์",
                                isObscure: false,
                                textInputType: "number",
                                textEditingController: phoneNumberController,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: widgetColor
                                                      .widgetShadow(),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: DropdownMenu(
                                              inputDecorationTheme:
                                                  InputDecorationTheme(
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                                  ),
                                              menuStyle: MenuStyle(
                                                shadowColor:
                                                    WidgetStateProperty.all(
                                                      widgetColor
                                                          .widgetShadow(),
                                                    ),
                                                elevation:
                                                    WidgetStateProperty.all(8),
                                                shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              onSelected: (value) {
                                                setState(() {
                                                  selectedGender = value;
                                                });
                                              },
                                              hintText: "เลือก",
                                              dropdownMenuEntries:
                                                  <DropdownMenuEntry<String>>[
                                                    DropdownMenuEntry(
                                                      value: "Male",
                                                      label: "ชาย",
                                                    ),
                                                    DropdownMenuEntry(
                                                      value: "Female",
                                                      label: "หญิง",
                                                    ),
                                                    DropdownMenuEntry(
                                                      value: "Other",
                                                      label: "อื่นๆ",
                                                    ),
                                                  ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "วันเกิด",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            clickDob = !clickDob;
                                          });
                                          birthDayData(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                          ),
                                          height: 55,
                                          width: 139,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: widgetColor
                                                    .widgetShadow(),
                                                offset: Offset(1, 2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                child: Text(
                                                  dayController.text.isNotEmpty
                                                      ? "${dayController.text}/${monthController.text}/${yearController.text}"
                                                      : "กดเพื่อกรอก",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    clickDob = !clickDob;
                                                  });
                                                  birthDayData(context);
                                                },
                                                icon: clickDob
                                                    ? Icon(Icons.arrow_drop_up)
                                                    : Icon(
                                                        Icons.arrow_drop_down,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => AuthService().registerButtonAction(
                              emailController,
                              nameController,
                              passwordController,
                              selectedGender,
                              dayController,
                              monthController,
                              yearController,
                              confirmPasswordController,
                              context,
                              phoneNumberController,
                            ),
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

  Future<dynamic> birthDayData(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("วัน"),
                    TextField(
                      decoration: InputDecoration(hintText: dayController.text),
                      controller: dayController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              VerticalDivider(thickness: 1),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("เดือน"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: monthController.text,
                      ),
                      controller: monthController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              VerticalDivider(thickness: 1),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("ปี"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: yearController.text,
                      ),
                      controller: yearController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("ยกเลิก", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                clickDob = !clickDob;
              });
              Navigator.pop(context);
            },
            child: Text("บันทึก"),
          ),
        ],
      ),
    );
  }
}
