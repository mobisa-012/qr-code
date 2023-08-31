// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/core/const/margins.dart';
import 'package:qr_code/core/const/path_const.dart';
import 'package:qr_code/core/const/text_const.dart';
import 'package:qr_code/core/services/auth_service.dart';
import 'package:qr_code/screens/bottom_bar/page/bottom_bar.dart';
import 'package:qr_code/screens/signup/signup.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final emailAuthService = EmailAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Image.asset(PathConstants.code),
              ),
              YMargin(y: 5),
              Text(
                TextConstants.letsSignYou,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400),
              ),
              const Text(
                'QR Code Scanner',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              YMargin(y: 20),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                  key: formKey,
                  controller: emailController,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Email..',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Colors.lightBlue,
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
             YMargin(y: 20),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Form(
                  key: passwordKey,
                  child: TextFormField(
                    validator: (password) {
                      final RegExp regExp =
                          RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                      if (!regExp.hasMatch(password!)) {
                        return 'Password must contain at least one letter, one number, and be at least 8 characters long';
                      }
                      return null;
                      // returns null if password is valid
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Password..',
                        prefixIcon: const Icon(
                          Icons.vpn_key,
                          size: 30,
                          color: Colors.lightBlue,
                        )),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              YMargin(y: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                  minimumSize: Size(MediaQuery.of(context).size.width /0.3, 55),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                onPressed: () async {
  try {
    final email = emailController.text;
    final password = passwordController.text;
    
    final signInResult = await emailAuthService.signInWithEmailAndPassword(email, password);

    if (signInResult != null) {
      // Sign-in successful, navigate to the home page
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BottomBar()));
    } else {
      // Sign-in failed, handle errors
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign-in failed. Please check your credentials or register to continue.'),
      ));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User not found. Please sign up to continue.'),
      ));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Wrong password. Please try again.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
    }
  } catch (error) {
    // Handle other errors
    print('Error: $error');
  }
},

                child: const Text(
                  TextConstants.signIn,
                  style: TextStyle(fontSize: 20,
                  color: Colors.white),
                ),
              ),
              YMargin(y: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    TextConstants.noAccount,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignUpPage()));
                    },
                    child: const Text(
                      TextConstants.register,
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              YMargin(y: 10),              
            ],
          ),
        ),
      ),
    );
  }

  // bool validatePassword(String password) {
  //   final RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  //   return regExp.hasMatch(password);
  // }
}
