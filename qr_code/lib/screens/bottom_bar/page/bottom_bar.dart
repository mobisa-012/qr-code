import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/core/enums/bottom_bar.dart';
import 'package:qr_code/screens/bottom_bar/bloc/bottm_bar_bloc.dart';
import 'package:qr_code/screens/home/home_page.dart';
import 'package:qr_code/screens/onboarding/page/onboarding.dart';
import 'package:qr_code/screens/settings/settings.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
              icon: Icon(Icons.email), label: 'Home'
              ),  
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account')
              ],
              onTap: (int index) {
                if(index ==0) {
                  BlocProvider.of<BottomBarCubit>(context)
                  .getBottomBarItem(BottomBarItem.home);
                } else {
                    if(index==1) {
                      BlocProvider.of<BottomBarCubit>(context)
                  .getBottomBarItem(BottomBarItem.account);
                    }
                  }
                }              
            );
        },
      ),
      body: BlocBuilder<BottomBarCubit, BottomBarState> (
        builder: (context, state) {
          if(state.bottomBarItem == BottomBarItem.home) {
            return const HomePage();
          }  else if(state.bottomBarItem == BottomBarItem.account){
            return const AccountPage();
          }
          return const OnboardingPage();
        },
      ),
    );
  }
}