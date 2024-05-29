import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/user_interface/main_screen.dart';

void main() {
  runApp(ProviderScope(
    child: Builder(
      builder: (context) {
        return const MaterialApp(
          home: MainScreen(),
          
          );
      }
    ),
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
    super.initState();
    
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.white,
            strokeWidth: 2.0,
            value: Checkbox.width,
            semanticsLabel: String.fromCharCode(1),
          ),
        ),
    );
  }
}