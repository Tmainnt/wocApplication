class User {
  String _token;
  String _email;
  String _name;
  String _gender;
  DateTime _dof;
  String _phone;
  String _role;
  String _profileImage;
  String _status;
  DateTime _createTimestamp;
  DateTime _updateTimestamp;

  User({
    required String token,
    required String email,
    required String name,
    required String gender,
    required DateTime dof,
    required String phone,
    required String role,
    required String profileImage,
    required String status,
    required DateTime cts,
    required DateTime uts,
  }) : _token = token,
       _email = email,
       _name = name,
       _gender = gender,
       _dof = dof,
       _phone = phone,
       _role = role,
       _profileImage = profileImage,
       _status = status,
       _createTimestamp = cts,
       _updateTimestamp = uts;

  factory User.fromJson(Map<String, dynamic> json, String tokenStr) {
    return User(
      token: tokenStr,
      email: json["user_email"],
      name: json["user_name"],
      dof: json["date_of_birth"],
      phone: json["phone_number"] ?? "",
      gender: json["gender"],
      role: json["role"],
      profileImage: json["profile_image"] ?? "",
      status: json["status"],
      cts: json["create_timestamp"],
      uts: json["update_timestamp"],
    );
  }

  String get token => _token;
  String get email => _email;
  String get name => _name;
  String get gender => _gender;
  DateTime get dof => _dof;
  String get phone => _phone;
  String get role => _role;
  String get profileImage => _profileImage;
  String get status => _status;
  DateTime get createTimestamp => _createTimestamp;
  DateTime get updateTimestamp => _updateTimestamp;
}
