class CheckRegularExpression {

  const CheckRegularExpression();
  
  bool checkEmail(String email) {
    final regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+/.[a-zA-Z]{2,}$');
    return regEx.hasMatch(email);
  }

  bool checkPasswrod(){
    return true;
  }
  
}