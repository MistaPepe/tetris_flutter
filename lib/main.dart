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
