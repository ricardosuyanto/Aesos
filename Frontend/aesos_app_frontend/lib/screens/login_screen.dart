import 'dart:convert';

import 'package:aesos_app_frontend/utils/color.dart';
import 'package:aesos_app_frontend/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/user.dart';
import '../resources/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  Future<void> login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    var res = await AuthMethod().login(username: username, password: password);

    if (res!.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);

      String username = map['username'];
      String user = map['user'];
      String message = map['message'];
      print(message);
      print(user);
      print(username);

      final data = jsonDecode(res.body);
      // Map<String, dynamic> map = jsonDecode(res.body);
      // String name = map['name'];
      // int age = map['age'];
      Login login = Login.fromJson(data);
      print(login.message);
    } else {
      print("eror");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              isPass: true,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: login,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor),
                child: const Text('Log in'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Don't you have an account?"),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
