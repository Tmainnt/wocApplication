import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/view/authentication/login_form.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginForm());
  }
}
