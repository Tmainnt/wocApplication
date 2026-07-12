class User {
  String _token;
  String _email;
  String _name;
  String _gender;
  DateTime _dob;
  String _phone;
  String _role;
  String _profileImage;
  String _backgroundImage;
  String _status;
  DateTime _createTimestamp;
  DateTime _updateTimestamp;

  User({
    required String token,
    required String email,
    required String name,
    required String gender,
    required DateTime dob,
    required String phone,
    required String role,
    required String profileImage,
    required String backgroundImage,
    required String status,
    required DateTime cts,
    required DateTime uts,
  }) : _token = token,
       _email = email,
       _name = name,
       _gender = gender,
       _dob = dob,
       _phone = phone,
       _role = role,
       _profileImage = profileImage,
       _backgroundImage = backgroundImage,
       _status = status,
       _createTimestamp = cts,
       _updateTimestamp = uts;

  factory User.fromJson(Map<String, dynamic> json, String tokenStr) {
    return User(
      token: tokenStr,
      email: json["user_email"],
      name: json["user_name"],
      dob: json["date_of_birth"],
      phone: json["phone_number"] ?? "",
      gender: json["user_gender"],
      role: json["user_role"],
      profileImage: json["profile_image"] ?? "",
      backgroundImage: json["background_image"] ?? "",
      status: json["user_status"],
      cts: json["create_timestamp"],
      uts: json["update_timestamp"],
    );
  }

  String get token => _token;
  String get email => _email;
  String get name => _name;
  String get gender => _gender;
  DateTime get dob => _dob;
  String get phone => _phone;
  String get role => _role;
  String get profileImage => _profileImage;
  String get backgroundImage => _backgroundImage;
  String get status => _status;
  DateTime get createTimestamp => _createTimestamp;
  DateTime get updateTimestamp => _updateTimestamp;
}
