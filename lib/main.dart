import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/service/token_service.dart';
import 'package:woc/view/authentication/login_form.dart';
import 'package:woc/view/home_page.dart';
import 'package:woc/service/cache_service.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CacheService().setUserProvider();
    return FutureBuilder(
      future: TokenService.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginForm(),
        );
      },
    );
  }
}
