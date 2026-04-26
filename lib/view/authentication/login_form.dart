import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:woc/theme/text_color.dart";
import "package:woc/theme/widget_color.dart";
import "package:woc/view/authentication/register_form.dart";
import "package:woc/widget/auth/custom_textfield.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LogFormState();
}

class LogFormState extends State<LoginForm> {
  bool isObscure = false;
  WidgetColor widgetColor = WidgetColor();
  TextColor textColor = TextColor();

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
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Pedometer & ",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Workout",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ยินดีต้อนรับสู่แอปสุขภาพและการออกกำลังกาย",
                      style: TextStyle(fontSize: 15),
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
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "ยังไม่เป็นสมาชิก? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "สมัครสมาชิก",
                            style: TextStyle(
                              color: textColor.highlightTextAuth(),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterForm(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(color: widgetColor.dividerColor(), thickness: 1),
                    SizedBox(height: 15),
                    _signInWithGoogle(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInWithGoogle() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: widgetColor.textfieldShadow()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/image/google_logo.png', height: 24),
          const SizedBox(width: 12),
          const Text(
            "ดำเนินการต่อโดยใช้ Google",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
