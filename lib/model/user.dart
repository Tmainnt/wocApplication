class User {
  String _email;
  String _name;
  String _gender;
  String _dof;
  String _phone;
  String _role;

  User({
    required String email,
    required String name,
    required String gender,
    required String dof,
    required String phone,
    required String role,
  }) : _email = email,
       _name = name,
       _gender = gender,
       _dof = dof,
       _phone = phone,
       _role = role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["user_email"],
      name: json["user_name"],
      dof: json["date_of_birth"],
      phone: json["phone_number"],
      gender: json["user_gender"],
      role: json["role"],
    );
  }

  String get email => _email;
  String get name => _name;
  String get gender => _gender;
  String get dof => _dof;
  String get phone => _phone;
  String get role => _role;
}
