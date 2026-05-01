import 'package:flutter/material.dart';
import 'package:woc/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get queryUser => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
