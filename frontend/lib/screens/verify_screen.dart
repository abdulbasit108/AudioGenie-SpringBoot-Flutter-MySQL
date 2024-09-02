import 'package:audio_genie/services/auth_service.dart';
import 'package:audio_genie/utils/constants.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String username;
  const VerifyScreen({super.key, required this.username});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final AuthService authService = AuthService();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  

  void _verify() {
    if (_formKey.currentState?.validate() ?? false) {
      authService.verifyAccount(context: context, username: widget.username, verificationCode: _otpController.text);
    }
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
          height: screenHeight * 0.6,
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
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Almost there - check your inbox',
                  style: TextStyle(
                    fontFamily: kPrimaryFont,
                    fontSize: 20,
                    color: kSecondaryLightColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To finish signing up, enter the code we just sent to ${widget.username}',
                  style: TextStyle(
                    fontFamily: kPrimaryFont,
                    fontSize: 16,
                    color: kSecondaryLightColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor
                        ),
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: 'Code',
                        labelStyle: TextStyle(
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor
                        ),
                        
                        border: InputBorder.none,
                        filled: true,
                        fillColor: kPrimaryDarkColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the code';
                        }
                        if (value.length < 6 || value.length > 6) {
                          return '6-digit code is required';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _verify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryLightColor,
                        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                        padding: const EdgeInsets.all(18)
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: kPrimaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryDarkColor
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive a code? ',
                    style: TextStyle(
                      color: kSecondaryLightColor,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      'Resend Code',
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