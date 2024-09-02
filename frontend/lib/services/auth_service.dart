// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audio_genie/screens/home_screen.dart';
import 'package:audio_genie/screens/landing_screen.dart';
import 'package:audio_genie/screens/login_screen.dart';
import 'package:audio_genie/utils/constants.dart';
import 'package:audio_genie/utils/error_handling.dart';
import 'package:audio_genie/screens/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signUp user
  void signUpUser({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/signup'),
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": username,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created!');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyScreen(
                      username: username,
                    )),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/login'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'Authorization', 'Bearer ${jsonDecode(res.body)['token']}');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void verifyAccount({
    required BuildContext context,
    required String? username,
    required String? verificationCode,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/verify'),
        body: jsonEncode({
          'username': username,
          'verificationCode': verificationCode,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(
              context,
              'Account Verified Successfully',
            );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('Authorization', '');

      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingScreen()),
            );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
