import 'package:aesos_app_frontend/model/user.dart';
import 'package:aesos_app_frontend/resources/auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethod _authMethods = AuthMethod();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
