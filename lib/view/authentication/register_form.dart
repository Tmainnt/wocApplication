import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:woc/theme/text_color.dart';
import 'package:woc/theme/widget_color.dart';
import 'package:woc/view/authentication/login_form.dart';
import 'package:woc/widget/auth/custom_textfield.dart';
import 'package:woc/constant/app_enum.dart';
import 'package:woc/controller/authentication/register_controller.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final RegisterController registerController = RegisterController();
  bool isLoading = false;
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();

  bool invalidPasswordLengthLabel = false;
  bool invalidConfirmPasswordLabel = false;
  bool duplicateEmailLabel = false;

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
                  Colors.black.withValues(alpha: 0.6),
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
                                textEditingController: registerController.emailController,
                                inputType: InputType.email,
                                borderColorController: registerController.emailBorderColorController,
                              ),
                              CustomTextField(
                                topic: "ชื่อผู้ใช้งาน",
                                isObscure: false,
                                textInputType: "",
                                textEditingController: registerController.nameController,
                                inputType: InputType.username,
                                borderColorController: registerController.usrBorderColorController,
                              ),
                              CustomTextField(
                                topic: "รหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                                textEditingController: registerController.passwordController,
                                inputType: InputType.passwrod,
                                borderColorController: registerController.pwdBorderColorController,
                              ),
                              CustomTextField(
                                topic: "ยืนยันรหัสผ่าน",
                                isObscure: true,
                                textInputType: "",
                                textEditingController:
                                    registerController.confirmPasswordController,
                                inputType: InputType.confirmPassword,
                                borderColorController: registerController.conPwdBoderColorController,
                              ),
                              CustomTextField(
                                topic: "เบอร์โทรศัพท์",
                                isObscure: false,
                                textInputType: "number",
                                textEditingController: registerController.phoneNumberController,
                                inputType: InputType.phoneNumber,
                                borderColorController: registerController.phoneBorderColorController,
                              ),
                              Row(
                                /*mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,*/
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
                                              border: Border.all(
                                                color: registerController.genderBorderColorController
                                              ),
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
                                                  registerController.selectedGender = value;
                                                });
                                              },
                                              hintText: "เลือก",
                                              dropdownMenuEntries:
                                                  <DropdownMenuEntry<String>>[
                                                    DropdownMenuEntry(
                                                      value: "male",
                                                      label: "ชาย",
                                                    ),
                                                    DropdownMenuEntry(
                                                      value: "female",
                                                      label: "หญิง",
                                                    ),
                                                    DropdownMenuEntry(
                                                      value: "other",
                                                      label: "อื่นๆ",
                                                    ),
                                                  ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
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
                                            registerController.setClickDobStatus();
                                          });
                                          registerController.pickDateOfBirth(context);
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
                                            border: Border.all(
                                              color: registerController.dobBorderColorController
                                            )
                                          ),
                                          child: ListenableBuilder(
                                            listenable: registerController, 
                                            builder: (context, _) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    registerController.dateOfBirth,
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      registerController.setClickDobStatus();
                                                    });
                                                    registerController.pickDateOfBirth(context);
                                                  },
                                                  icon: registerController.clickDob
                                                      ? Icon(Icons.arrow_drop_up)
                                                      : Icon(
                                                          Icons.arrow_drop_down,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ) 
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
                          : () => registerController.registerButtonAction(context),
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

  void showDatePick() {
    
  }
}
