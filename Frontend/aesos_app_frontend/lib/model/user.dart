import 'dart:convert';

class User {
  final String username;
  final String email;
  final String password;
  final int id;

  // ignore: non_constant_identifier_names
  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'id': id
    };
  }

  static Map<String, dynamic> toMap(User user) => <String, dynamic>{
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'id': user.id
      };

  static String serialize(User user) => json.encode(User.toMap(user));

  static User deserialize(String? json) => User.fromJson(jsonDecode(json!));
}

class Login {
  final String message;
  final String token;
  final User user;

  Login({required this.message, required this.token, required this.user});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
