import "package:flutter/material.dart";

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LogFormState();
}

class LogFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext contexct) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(""), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Pedometer &",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Workout",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
