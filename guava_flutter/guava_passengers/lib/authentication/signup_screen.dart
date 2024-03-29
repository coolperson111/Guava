import 'package:flutter/material.dart';
import 'package:guava_passengers/authentication/login_screen.dart';
import 'package:guava_passengers/methods/common_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNametextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkNetwork() {
    cMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation() {
    if (userNametextEditingController.text.trim().length < 4) {
      cMethods.displaySnackBar("Name must be >4 characters", context);
    } else if (phonetextEditingController.text.trim().length != 10) {
      cMethods.displaySnackBar("Phone number must have 10 digits", context);
    } else if (!emailtextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("Invalid Email", context);
    } else if (passwordtextEditingController.text.trim().length < 6) {
      cMethods.displaySnackBar("Password must have atleast 6 characters", context);
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
                        "Create an account",
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

                                // username
                                TextField(
                                  controller: userNametextEditingController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: "User Name",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "User Name",
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

                                //phone no.
                                TextField(
                                  controller: phonetextEditingController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: "User Phone",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "User Phone",
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
                                    "Sign Up"
                                  )
                                ),

                              ],
                            )
                      ),

                      const SizedBox(height: 12,),

                      //textButton - login
                      TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> const LogInScreen()));
                        },
                        child: const Text(
                          "Already have an Account? Login here",
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
