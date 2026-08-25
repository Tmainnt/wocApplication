import 'package:flutter/material.dart';
import 'package:woc/service/auth_service.dart';

class RegisterController extends ChangeNotifier {
  
  RegisterController();

  String? selectedGender;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DateTime? selectedDate;
  bool clickDob = false;
  bool emailBorderColorController = true;
  bool nameBorderColorController = true;
  bool pwdBorderColorController = true;
  bool conPwdBoderColorController = true;
  bool phoneBorderColorController = true;
  bool genderBorderColorController = true;
  bool dobBorderColorController = true;
  


  Future<bool> registerButtonAction() async{
    if (validateInput()) {

      try {
        await AuthService().registerResponseStatusCode(
          emailController.text,
          nameController.text,
          passwordController.text,
          selectedGender,
          numberToStringFormat(selectedDate!.day),
          numberToStringFormat(selectedDate!.month),
          selectedDate!.year.toString(),
          confirmPasswordController.text,
          phoneNumberController.text,
        );
        return true;
      } catch (e) {
        return false;
      }
    }
    notifyListeners();
    return false;
  }

  void pickDateOfBirth(BuildContext context) async {
    DateTime? datePick = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2100)
    );
    selectedDate = datePick;
    setClickDobStatus();
    notifyListeners();
  }

  String get dateOfBirth {
    if (selectedDate != null) {
      return "${numberToStringFormat(selectedDate!.day)}/${numberToStringFormat(selectedDate!.month)}/${selectedDate!.year.toString()}";
    } else {
      return "วัน/เดือน/ปี";
    }
  }

  void setClickDobStatus() {
    clickDob = !clickDob;
  }

  String numberToStringFormat(int number){
    return number.toString().padLeft(2, '0');
  }

  bool validateInput() {
    bool status = true;
    if (emailController.text.isEmpty) {
      status = false;
      emailBorderColorController = false;
    }
    if (nameController.text.isEmpty){
      status = false;
      nameBorderColorController = false;
      
    }
    if (passwordController.text.isEmpty){
      status = false;
      pwdBorderColorController = false;
    }
    if (confirmPasswordController.text.isEmpty ){
      status = false;
      conPwdBoderColorController = false;
      if (passwordController.text != confirmPasswordController.text && passwordController != false) pwdBorderColorController = false; 
    }
    if (phoneNumberController.text.isEmpty){
      status = false;
      phoneBorderColorController = false;

    }
    if (selectedGender == null || selectedGender!.isEmpty){
      status = false;
      genderBorderColorController = false;
    }

    if (selectedDate == null) {
      status = false;
      dobBorderColorController = false;
    }

    return status;
  }

}