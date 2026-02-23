import 'package:brundhavanam/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const TextStyle mainHeading = TextStyle(
    fontFamily: 'DynaPuff',
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 1.0,

    letterSpacing: 0.22,
    color: Colors.white,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0, // line-height 100%
    letterSpacing: 0.16, // ~1% of 16px
  );

  static const TextStyle regular = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0, // line-height 100%
    letterSpacing: 0.16, // ~1% of 16px
  );

  static const TextStyle medium = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.0, // line-height 100%
    letterSpacing: 0.16, // ~1% of 16px
  );

  static const TextStyle semibold = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.20, // line-height 100%
    letterSpacing: 0.18, // ~1% of 16px
    color: AppColors.white,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    height: 1.4,
    color: Colors.black87,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
