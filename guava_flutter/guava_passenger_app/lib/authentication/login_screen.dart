//import 'dart:js';
//import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guava_passenger_app/authentication/signup_screen.dart';
import 'package:guava_passenger_app/methods/common_methods.dart';
import 'package:guava_passenger_app/pages/home_page.dart';
import 'package:guava_passenger_app/widgets/loading_dialog.dart';
import '../global/global_var.dart';
import '../methods/common_methods.dart';
import '../widgets/loading_dialog.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();


  checkNetwork() {
    cMethods.checkConnectivity(context);
    signInFormValidation();
  }

  signInFormValidation() {
       if (!emailtextEditingController.text.contains("@")) {
        cMethods.displaySnackBar("Invalid Email", context);
      } else if (passwordtextEditingController.text.trim().length < 6) {
        cMethods.displaySnackBar("Password must have atleast 6 characters", context);
      }
      else {
        signInUser();
      }
  }

  signInUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext) => LoadingDialog(messageText: "Allowing you to login..."),
    );
    final User? userFirebase = (
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailtextEditingController.text.trim(),
        password: passwordtextEditingController.text.trim(),
      ).catchError((errorMsg)
      {
        Navigator.pop(context);
        cMethods.displaySnackBar(errorMsg.toString(),context);
      })
    ).user;

    if(!context.mounted) return;
    Navigator.pop(context);


    if(userFirebase != null) {
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase.uid);
      usersRef.once().then((snap)
      {
        if(snap.snapshot.value != null) {
          if((snap.snapshot.value as Map)["blockStatus"] == "no") {
            userName = (snap.snapshot.value as Map)["name"];
            Navigator.push(context, MaterialPageRoute(builder: (c)=> HomePage()));
          } else {
            FirebaseAuth.instance.signOut();
            cMethods.displaySnackBar("You are blocked", context);
          }
        }
        else {
          FirebaseAuth.instance.signOut();
          cMethods.displaySnackBar("Your records do not exist", context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                      "assets/images/logo.jpeg"
                  ),

                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //text fields + button
                  Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [

                          //email
                          TextField(
                            controller: emailtextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "User Email",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "User Email",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 22,),

                          //password
                          TextField(
                            controller: passwordtextEditingController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "User Password",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "User Password",
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 32,),

                          //submit button
                          ElevatedButton(
                              onPressed: ()
                              {
                                checkNetwork();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                              ),
                              child: const Text(
                                  "Login"
                              )
                          ),

                        ],
                      )
                  ),

                  const SizedBox(height: 12,),

                  //textButton - sign up
                  TextButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignUpScreen()));
                      },
                      child: const Text(
                        "Don't have an account? Sign Up here",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                  ),

                ],
              ),
            )
        )
    );
  }
}