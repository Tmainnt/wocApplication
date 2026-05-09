import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";
import "package:woc/provider/user_provider.dart";
import 'package:woc/view/home_page.dart';
import "package:woc/model/user.dart";
import "package:woc/view/authentication/login_form.dart";

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

  void registerButtonAction(
    TextEditingController emailController,
    TextEditingController nameController,
    TextEditingController passwordController,
    String? selectedGender,
    TextEditingController dayController,
    TextEditingController monthController,
    TextEditingController yearController,
    TextEditingController confirmPasswordController,
    BuildContext context,
    TextEditingController phoneNumberController,
  ) async {
    if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedGender != null &&
        (dayController.text.isNotEmpty &&
            monthController.text.isNotEmpty &&
            yearController.text.isNotEmpty)) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("รหัสผ่านไม่ตรงกัน")));
        return;
      }
      final url = Uri.parse(
        "https://kindling-magnifier-late.ngrok-free.dev/register",
      );

      final String dob =
          "${dayController.text}/${monthController.text}/${yearController.text}";

      final response = await http.post(
        url,
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          "user_name": nameController.text,
          "user_email": emailController.text,
          "user_pass": passwordController.text,
          "gender": selectedGender,
          "date_of_birth": dob,
          "phone_number": phoneNumberController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginForm()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("สมัครไม่สำเร็จ")));
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบ")));
    }
  }
}
