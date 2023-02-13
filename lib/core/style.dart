import 'package:flutter/material.dart';

abstract class AppColors{

  static const primary = Colors.black;
  static const contrast = Colors.white;

  static const appBar = Color(0x9FD3EFCF);
  static const backGround = Color(0x9FEDF8E1);

  static const tokenA = Colors.deepOrange;
  static const tokenB = Colors.pinkAccent;

}

abstract class AppTheme{
  static BoxShadow shadow = BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: const Color(0xFFADADAD).withOpacity(0.25),
  );
}