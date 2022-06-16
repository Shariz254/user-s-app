import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentications/sign_up_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreens/user_splash_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /**form validation done here**/
  validateForm(){

    if(!emailController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Invalid Email");
      }
      else if(passwordController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Password is Required!");
      }
    else
    {
      LoginUserData();
    }
  }

  //saving to Firebase db
  LoginUserData() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Please Wait ..,",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),

          //trim is to remove extra space typed(white space)
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " +msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfull");

      Navigator.push(context, MaterialPageRoute(builder: (c) => const UserSplashScreen()));


    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error while Logging In");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 10.0),
                child: Text(
                  "Login As User",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Form(
                  key: _formKey,
                  child: Center(
                    child: Column(

                      children: [
                        CustomTextField(
                          controller: emailController,
                          hintText: "email*",
                          isObscure: false,
                        ),

                        CustomTextField(
                          controller: passwordController,
                          hintText: "Password*",
                          isObscure: false,
                        ),

                      ]

                    ),
                  )
              ),

              SizedBox(height: 30,),

              Center(
                child: Container(
                  height: 50,
                  width: 190,
                  child: TextButton(
                      child: Text(
                          "LOGIN".toUpperCase(),
                          style: TextStyle(fontSize: 18)
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.blue)
                              )
                          )
                      ),
                      onPressed: () {
                        validateForm();
                        // Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
                      }
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));

                },
                child: const Text(
                  "Don't Have an Account.? Register Here..",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
