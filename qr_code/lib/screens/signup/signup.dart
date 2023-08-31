import 'package:flutter/material.dart';
import 'package:qr_code/core/const/path_const.dart';
import 'package:qr_code/core/const/text_const.dart';
import 'package:qr_code/core/services/auth_service.dart';
import 'package:qr_code/screens/bottom_bar/page/bottom_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final pawwordKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailAuthService = EmailAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: Image.asset(PathConstants.code),
              ),
              // email field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Your Email..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Colors.lightBlue,
                      )),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Please enter email..';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              // password field
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                  key: pawwordKey,
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
              const SizedBox(
                height: 28,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                    minimumSize: Size(MediaQuery.of(context).size.width /0.3, 55),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    emailAuthService.signUpWithEmailAndPassword(
                        email, password, context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const BottomBar())
                        );
                  },
                  child: const Text(
                    TextConstants.signUp,
                    style: TextStyle(fontSize: 20,
                    color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
