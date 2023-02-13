import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:konomic/core/view/home.dart';
import 'package:konomic/f.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: KonanicScreen()

    );
  }
}
