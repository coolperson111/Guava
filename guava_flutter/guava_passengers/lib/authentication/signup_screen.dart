import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
    const SignUpScreen({super.key});

    @override
        State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                                    "Create a user's account",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    )

                                    ],
                                ),
                            )
                        )
                    );
        }
}
