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
  bool validEmail = true;
  bool validName = true;
  bool validPassword = true;
  bool validConfirmPassword = true;
  bool validPhoneNumber = true;
  bool validGender = true;
  bool validDob = true;
  

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    selectedDate = null;
    super.dispose();
  }

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
      validEmail = false;
    }
    if (nameController.text.isEmpty){
      status = false;
      validName = false;
      
    }
    if (passwordController.text.isEmpty){
      status = false;
      validPassword = false;
    }
    if (confirmPasswordController.text.isEmpty ){
      status = false;
      validConfirmPassword = false;
      if (passwordController.text != confirmPasswordController.text && validPassword != false) validPassword = false; 
    }
    if (phoneNumberController.text.isEmpty){
      status = false;
      validPhoneNumber = false;

    }
    if (selectedGender == null || selectedGender!.isEmpty){
      status = false;
      validGender = false;
    }

    if (selectedDate == null) {
      status = false;
      validDob = false;
    }

    return status;
  }


  void clearErrorEmail() {
    if (!validEmail) {
      validEmail = true;
      notifyListeners();
    }
  }

  void clearErrorName() {
    if (!validName) {
      validName = true;
      notifyListeners();
    }
  }

  void clearErrorPassword() {
    if (!validPassword) {
      validEmail = true;
      notifyListeners();
    }
  }

  void clearErrorConfirmPassword() {
    if (!validConfirmPassword) {
      validConfirmPassword = true;
      notifyListeners();
    }
  }

  void clearErrorPhoneNumber() {
    if (!validPhoneNumber) {
      validPhoneNumber = true;
      notifyListeners();
    }
  }

  void clearErrorGender() {
    if (!validGender) {
      validGender = true;
      notifyListeners();
    }
  }

  void clearErrorDob() {
    if (!validDob) {
      validDob = true;
      notifyListeners();
    }
  }

}