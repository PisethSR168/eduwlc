import 'package:flutter/material.dart';
import 'package:eduwlc/view/splash.dart';
import 'package:eduwlc/view/home_page.dart';
import 'package:eduwlc/view/course_detail.dart';
import 'package:eduwlc/view/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
