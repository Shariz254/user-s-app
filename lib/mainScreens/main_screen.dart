import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreens/user_splash_screen.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          child: const Text(
            "Sign Out",
          ),
          onPressed: ()
          {

            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c) => const UserSplashScreen()));

          },
        )
    );
  }
}
