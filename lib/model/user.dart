class User {
  String _token;
  String _email;
  String _name;
  String _gender;
  String _dof;
  String _phone;
  String _role;

  User({
    required String token,
    required String email,
    required String name,
    required String gender,
    required String dof,
    required String phone,
    required String role,
  }) : _token = token,
       _email = email,
       _name = name,
       _gender = gender,
       _dof = dof,
       _phone = phone,
       _role = role;

  factory User.fromJson(Map<String, dynamic> json, String tokenStr) {
    print("Now u are in UserModel \n This is token: ${tokenStr}");
    print(
      "${json["user_email"]} \n ${json["user_name"]} \n ${json["date_of_birth"]} \n ${json["phone_number"]} \n ${json["user_gender"]} \n ${json["role"]}",
    );

    return User(
      token: tokenStr,
      email: json["user_email"],
      name: json["user_name"],
      dof: json["date_of_birth"],
      phone: json["phone_number"] ?? "",
      gender: json["gender"],
      role: json["role"],
    );
  }

  String get token => _token;
  String get email => _email;
  String get name => _name;
  String get gender => _gender;
  String get dof => _dof;
  String get phone => _phone;
  String get role => _role;
}
