import "dart:convert";

import "package:http/http.dart" as http;
import "package:woc/model/user.dart";

class AuthService {
  Future<User> loginResponseStatusCode(String email, String password) async {
    final url = Uri.parse(
      "https://kindling-magnifier-late.ngrok-free.dev/login",
    );
    final response = await http.post(
      url,
      headers: {"content-type": "application/json"},
      body: jsonEncode({"user_email": email, "user_pass": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userData = User.fromJson(data['user'], data['token']);
      return userData;
    } else {
      throw Exception("Failed to fetch user data");
    }
  }

  Future<void> registerResponseStatusCode(
    String email,
    String name,
    String password,
    String? selectedGender,
    String day,
    String month,
    String year,
    String confirmPassword,
    String phoneNumber,
  ) async {
    final url = Uri.parse(
      "https://kindling-magnifier-late.ngrok-free.dev/register",
    );

    final String dob = "${day}/${month}/${year}";

    final response = await http.post(
      url,
      headers: {"content-type": "application/json"},
      body: jsonEncode({
        "user_name": name,
        "user_email": email,
        "user_pass": password,
        "gender": selectedGender,
        "date_of_birth": dob,
        "phone_number": phoneNumber,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Register failed");
    }
  }
}
