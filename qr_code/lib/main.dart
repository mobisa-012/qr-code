import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/core/services/auth_service.dart';
import 'package:qr_code/screens/bottom_bar/bloc/bottm_bar_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomBarCubit>(
      create: (context) => BottomBarCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Email Intergration App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: EmailAuthService().handleAuthState()
      ),
    );
  }
}