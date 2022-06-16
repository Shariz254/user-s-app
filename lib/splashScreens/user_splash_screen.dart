import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users_app/authentications/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/main_screen.dart';

class UserSplashScreen extends StatefulWidget
{
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  State<UserSplashScreen> createState() => _UserSplashScreen();
}

class _UserSplashScreen extends State<UserSplashScreen>
{

  startTimer(){
    Timer(const Duration(seconds: 3), () async
      {

        //checking if user is already logged in
        if(await fAuth.currentUser != null)
        {
          currentFirebaseUser = fAuth.currentUser;
          Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));

        } else {
          //send user to home screen
          Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
        }

      }

    );
  }


  @override
  void initState() {
    super.initState();

    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User's App",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
