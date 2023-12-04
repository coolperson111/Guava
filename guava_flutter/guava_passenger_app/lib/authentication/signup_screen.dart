import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guava_passenger_app/authentication/login_screen.dart';
import 'package:guava_passenger_app/methods/common_methods.dart';
import 'package:guava_passenger_app/pages/home_page.dart';
import 'package:guava_passenger_app/widgets/loading_dialog.dart';

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
    if(imageFile != null)//image validation
      {
        signUpFormValidation();
    }
    else
      {

      }

  }
uploadImageToStorage() async
{
  String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference referenceImage = FirebaseStorage.instance.ref().child("images").child(imageIDName)
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
    }else if (vehicleModelTextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Write Car Model", context);
    }else if (vehicleColorTextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Write Car Color", context);
    }else if (vehicleNUmberTextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Number", context);
    }
    else
    {
      uploadImageToStorage()

    }
  }
   registerNewUser() async
   {
     showDialog(
     context:context,
     barrierDismissible: false,
     builder:(BuildContext context)=> const LoadingDialog(messageText: "Registering your Account..."),
     );
     final User? userFirebase = (
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailtextEditingController.text.trim(),
       password: passwordtextEditingController.text.trim(),
     ).catchError((errorMsg)
     { cMethods.displaySnackBar(errorMsg.toString(),context);
     })
     ).user;
     if(!context.mounted) return;
     Navigator.pop(context);

     DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
     Map userDataMap=
         {
           "name":userNametextEditingController.text.trim(),
           "email":emailtextEditingController.text.trim(),
           "phone":phonetextEditingController.text.trim(),
           "id": userFirebase.uid,
           "blockStatus": "no",
         };
         usersRef.set(userDataMap);

         Navigator.push(context, MaterialPageRoute(builder:(c)=> HomePage()));

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
