class User {
  final String? username;
  final String? email;
  final String? password;
  final int? id;

  // ignore: non_constant_identifier_names
  User({this.username, this.email, this.password, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        id: json['id']
    );
  }
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
