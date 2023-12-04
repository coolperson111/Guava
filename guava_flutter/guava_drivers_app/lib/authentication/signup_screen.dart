import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../methods/common_methods.dart';
import '../pages/dashboard.dart';
import '../widgets/loading_dialog.dart';
import 'login_screen.dart';
//import 'package:guava_passenger_app/authentication/login_screen.dart';
//import 'package:guava_passenger_app/methods/common_methods.dart';
//import 'package:guava_passenger_app/pages/home_page.dart';
//import 'package:guava_passenger_app/widgets/loading_dialog.dart';

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

  TextEditingController carModeltextEditingController = TextEditingController();
  TextEditingController vehicleColortextEditingController = TextEditingController();
  TextEditingController NumberplatetextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();
  XFile? imageFile;


  checkNetwork() {
    cMethods.checkConnectivity(context);
    
    if(imageFile != null)
      {
        signUpFormValidation();
      }
    else{
      cMethods.displaySnackBar("Please choose image first", context);
    }

  }
  uploadImageToStorage() async
  {
    String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceImage = FirebaseStorage.instance.ref().child("Images").child(imageIDName);

    UploadTask uploadTask = referenceImage.putFile(File(imageFile!.path));
    TaskSnapshot snapshot = await uploadTask;
    urlOfUploadedImage = await snapshot.ref.getDownloadURL();

    setState((){
      urlOfUploadedImage;
    });

  }
  registerNewUser() async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(messageText: "Registering your account... "),

    );
    final User? userFirebase = (
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:emailtextEditingController.text.trim(),
      password:passwordtextEditingController.text.trim()
    ).catchError((errorMsg)
        Navigator.pop(context);
        cMethods.displaySnackBar(errorMsg.toString(),context);
  })
  ).user;


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
    else if (carModeltextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Car modal: ", context);
    }
    else if (vehicleColortextEditingController.text.trim().isEmpty) {
      cMethods.displaySnackBar("Car Colour: ", context);
    }
    else if (NumberplatetextEditingController.text.isEmpty) {
      cMethods.displaySnackBar("Number plate: ", context);
    }
    else
    {
      uploadImageToStorage();
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

         Navigator.push(context, MaterialPageRoute(builder:(c)=> Dashboard()));

   }
   chooseImageFromGallery()
   {
     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

     if(pickedFile != null)
       {
         setState(()
         {
           imageFile = pickedFile;
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

                  const SizedBox(
                    height: 40,
                  ),
                  imageFile == null ?

                  const CircleAvatar(
                    radius: 86,
                    backgroundImage: AssetImage("assets/images/avatarman.png"),
                  ) : Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: FileImage(
                          File(

                          )
                        )
                      )
                    )
                  ),

                  GestureDetector(
                    onTap: ()
                    {
                      chooseImageFromGallery();

                    },
                    child: const Text(
                      "Select Image",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                              labelText: "Your Name",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Your Name",
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
                              labelText: "Your Phone",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Your Phone",
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
                              labelText: "Your Email",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Your Email",
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
                              labelText: "Your Password",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Your Password",
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

                          TextField(
                            controller: carModeltextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Car Model",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Car Model",
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

                          TextField(
                            controller: vehicleColortextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Car Colour",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Car Colour",
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

                          TextField(
                            controller: NumberplatetextEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: "Car Number",
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: "Car Number",
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
