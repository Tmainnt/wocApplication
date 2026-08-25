import 'package:flutter/widgets.dart';
import 'package:woc/provider/user_provider.dart';
import 'package:woc/service/auth_service.dart';

class LoginController extends ChangeNotifier {

  bool validEmail = true;
  bool validPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserProvider _userProvider;
  LoginController(this._userProvider);

  Future<bool> loginButtonAction() async {
    if (validInput()) {
      try {
        final userData = await AuthService().loginResponseStatusCode(
          emailController.text,
          passwordController.text,
        );
        _userProvider.setUser(userData);
        return true;
      } catch (e) {
        return false;
      }
    }
    
    notifyListeners();
    return false;
  }

  bool validInput() {
    if (emailController.text.isEmpty) {
      validEmail = false;
    }

    if (passwordController.text.isEmpty) {
      validPassword = false;
    }
    return true;
  }


  
}