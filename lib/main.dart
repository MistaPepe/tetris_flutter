import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_flutter/user_interface/main_screen.dart';

void main() {
  runApp(Builder(
    builder: (context) {
      return MaterialApp(home: LoadingScreen());
    }
  ));
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.white,
            strokeWidth: 2.0,
            value: null,
            
          ),
        ),
    );
  }
}