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
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          strokeWidth: 2.0,
          value: null,
          backgroundColor: Colors.white,
        ),)
      );
  }
}