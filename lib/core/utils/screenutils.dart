import 'dart:math';
import 'package:flutter/material.dart';

class DesignConfig {
  DesignConfig();

  static int designWidth = 360;
  static int designHeight = 640;
  static double textScaleFactor = 0.97;

  static int designWidthLandscape = 640;
  static int designHeightLandscape = 360;

  static void updateConfig(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      designWidth = 640;
      designHeight = 360;
      textScaleFactor = 1.0;
      return;
    }

    if (orientation == Orientation.portrait && size.width >= 600) {
      designWidth = 720;
      designHeight = 837;
      textScaleFactor = 1.0;
    } else {
      designWidth = 360;
      designHeight = 640;
      textScaleFactor = 1.0;
    }
  }
}

class ScreenUtil {
  ScreenUtil._();

  static double screenWidth = 360;
  static double screenHeight = 640;
  static double scaleFactor = 0.97;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    scaleFactor = getScaleFactor();
    DesignConfig.updateConfig(context);
  }

  static double getScaleFactor() {
    final scaleWidth = screenWidth / DesignConfig.designWidth;
    final scaleHeight = screenHeight / DesignConfig.designHeight;
    final scaleText = min(scaleWidth, scaleHeight);
    return scaleText;
  }

  static double buildWidth(double width) {
    return width * screenWidth / DesignConfig.designWidth;
  }

  static double buildHeight(double height) {
    return height * screenHeight / DesignConfig.designHeight;
  }

  static double buildFontSize(double size) {
    return size * scaleFactor;
  }
}
