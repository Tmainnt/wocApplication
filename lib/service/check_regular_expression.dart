class CheckRegularExpression {

  CheckRegularExpression._();
  static final CheckRegularExpression  _instance = CheckRegularExpression._();

  CheckRegularExpression get getInstance => _instance;
  
  bool checkEmail(String email) {
    final regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+/.[a-zA-Z]{2,}$');
    return regEx.hasMatch(email);
  }

  bool checkPasswrod(){
    return true;
  }
  
}