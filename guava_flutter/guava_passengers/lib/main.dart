import 'package:flutter/material.dart';
import 'package:guava_passengers/authentication/signup_screen.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
        Widget build(BuildContext context) {
            return MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData.dark().copyWith(
                            scaffoldBackgroundColor: Colors.black,
                        ),
                    home: SignUpScreen(),
                    );
        }
}
