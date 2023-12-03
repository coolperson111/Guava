import 'package:flutter/material.dart';
import 'package:guava_passengers/authentication/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen ({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();

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
