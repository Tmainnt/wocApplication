import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> main() async {
  queryUser();
  insertuserData();
  queryUser();
}

Future<void> queryUser() async {
  final url = Uri.parse("https://kindling-magnifier-late.ngrok-free.dev/login");
  final response = await http.post(
    url,
    headers: {"content-type": "application/json"},
    body: jsonEncode({
      "user_email": "gamerthann@gmail.com",
      "user_pass": "Reyzaburrel123@",
    }),
  );

  if (response.statusCode == 400) {
    print("User not found");
  }

  if (response.statusCode == 401) {
    print("Password wrong");
  }

  if (response.statusCode == 500) {
    print("database error");
  }

  if (response.statusCode == 200) {
    print("user found");
    final userData = jsonDecode(response.body);
    print(userData);
    return;
  }
}

void insertuserData() async {
  final url = Uri.parse(
    "https://kindling-magnifier-late.ngrok-free.dev/register",
  );
  final response = await http.post(
    url,
    headers: {"content-type": "application/json"},
    body: jsonEncode({
      "user_name": "Thannkun",
      "user_pass": "Reyzaburrel123@",
      "user_email": "gamerthann@gmail.com",
      "gender": "Male",
      "date_of_birth": DateTime.now().toString(),
      "phone_number": "0614317635",
      "role": "Admin",
    }),
  );

  if (response.statusCode == 306) {
    print("invalid json");
    return;
  }

  if (response.statusCode == 400) {
    print("wtf are you doing? Please done everything before register sir.");
    return;
  }

  if (response.statusCode == 500) {
    print("hash error");
    return;
  }
}
