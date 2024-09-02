import 'package:audio_genie/services/auth_service.dart';
import 'package:audio_genie/utils/constants.dart';
import 'package:audio_genie/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService authService = AuthService();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Screen width and height
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      body: Center(
        child: Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.85,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kSecondaryDarkColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Audio Genie',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  fontSize: 32,
                  color: kSecondaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Sign up',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  fontSize: 24,
                  color: kSecondaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor),
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kPrimaryDarkColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kPrimaryDarkColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor),
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kPrimaryDarkColor,
                        suffixIcon: IconButton(
                          color: kSecondaryLightColor,
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authService.signUpUser(
                              context: context,
                              username: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryLightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(18)),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: kPrimaryFont,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryDarkColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: kSecondaryLightColor,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: kSecondaryLightColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
