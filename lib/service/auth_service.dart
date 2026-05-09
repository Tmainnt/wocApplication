import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";
import "package:woc/provider/user_provider.dart";
import 'package:woc/view/home_page.dart';
import "package:woc/model/user.dart";

class AuthService {
  Future<dynamic> loginButtonAction(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final url = Uri.parse(
        "https://kindling-magnifier-late.ngrok-free.dev/login",
      );
      final response = await http.post(
        url,
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "user_email": emailController.text,
          "user_pass": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final userData = User.fromJson(data['user'], data['token']);

        Provider.of<UserProvider>(context, listen: false).setUser(userData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else {
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("อีเมลหรือรหัสผ่านไม่ถูกต้อง")));
    }
  }
}
