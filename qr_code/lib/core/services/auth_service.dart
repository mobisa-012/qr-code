// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/screens/bottom_bar/page/bottom_bar.dart';
import 'package:qr_code/screens/onboarding/page/onboarding.dart';

class EmailAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Future<User?> registerUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     final UserCredential result = await firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     final User? user = result.user;
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

Future<void> signUpWithEmailAndPassword(String email, String password, BuildContext context) async {
  try {
    final existingUser = await firebaseAuth.fetchSignInMethodsForEmail(email);
    if (existingUser.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Sign up status'),
            content: const Text('This account already exists'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Sign up'),
              )
            ],
          );
        },
      );
      return;
    }

    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    print('User created: ${userCredential.user!.uid}');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const BottomBar()),
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Error: $e'),
        );
      },
    );
    print(e);
  }
}



  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const BottomBar();
          } else {
            return const OnboardingPage();
          }
        });
  }
}
