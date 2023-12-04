import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guava_passenger_app/authentication/signup_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if(valueOfPermission)
      {Permission.locationWhenInUse.request();}
  }
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guava',
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      /*
      theme: ThemeData.dark().cop(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        */
      home: SignUpScreen(),
    );
  }
}