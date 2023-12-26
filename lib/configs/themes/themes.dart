import 'package:flutter/material.dart';
import 'package:timekeeping/configs/themes/colors.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
  fontFamily: 'Roboto',
  useMaterial3: true,
);
