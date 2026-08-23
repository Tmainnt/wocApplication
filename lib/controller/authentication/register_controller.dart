import 'package:flutter/material.dart';
import 'package:woc/service/auth_service.dart';
import 'package:woc/view/authentication/login_form.dart';

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
  Color emailBorderColorController = Colors.black;
  Color usrBorderColorController = Colors.black;
  Color pwdBorderColorController = Colors.black;
  Color conPwdBoderColorController = Colors.black;
  Color phoneBorderColorController = Colors.black;
  Color genderBorderColorController = Colors.black;
  Color dobBorderColorController = Colors.black;
  


  dynamic registerButtonAction(BuildContext context) async{
    if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedGender != null &&
        selectedDate != null) {
      
      if (passwordController.text != confirmPasswordController.text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("รหัสผ่านไม่ตรงกัน, กรุณาลองอีกครั้ง")
          )
        );
      }

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
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginForm()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("สมัครไม่สำเร็จ")));
      }
    } else {
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("กรุณากรอกข้อมูลให้ครบ")));
    }
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
}