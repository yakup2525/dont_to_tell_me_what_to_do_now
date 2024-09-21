class UserRegisterModel {
  final String name;
  final String email;
  final String gsm;
  final String password;

  UserRegisterModel({
    required this.name,
    required this.email,
    required this.gsm,
    required this.password,
  });

  factory UserRegisterModel.fromFirebaseUser(
      UserRegisterModel userRegisterModel) {
    return UserRegisterModel(
      name: userRegisterModel.name,
      email: userRegisterModel.email,
      gsm: userRegisterModel.gsm,
      password: userRegisterModel.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gsm': gsm,
      'password': password,
    };
  }

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      name: json['name'],
      email: json['email'],
      gsm: json['gsm'],
      password: json['password'],
    );
  }
}
