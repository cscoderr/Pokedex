import 'package:flutter/material.dart';

enum ScreenSize {
  sm,
  md,
  lg,
  xl,
  xxl;

  bool get isLarge =>
      this == ScreenSize.lg || this == ScreenSize.xl || this == ScreenSize.xxl;

  double get breakpoint {
    switch (this) {
      case ScreenSize.sm:
        return 576;
      case ScreenSize.md:
        return 768;
      case ScreenSize.lg:
        return 992;
      case ScreenSize.xl:
        return 1200;
      case ScreenSize.xxl:
        return 1400;
    }
  }

  static ScreenSize fromWidth(double width) {
    if (width <= ScreenSize.sm.breakpoint) {
      return ScreenSize.sm;
    } else if (width <= ScreenSize.md.breakpoint) {
      return ScreenSize.md;
    } else if (width <= ScreenSize.lg.breakpoint) {
      return ScreenSize.lg;
    } else if (width <= ScreenSize.xl.breakpoint) {
      return ScreenSize.xl;
    } else {
      return ScreenSize.xxl;
    }
  }

  static int crossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= ScreenSize.sm.breakpoint) {
      return 2;
    } else if (screenWidth <= ScreenSize.md.breakpoint) {
      return 3;
    } else if (screenWidth <= ScreenSize.lg.breakpoint) {
      return 4;
    } else if (screenWidth <= ScreenSize.xl.breakpoint) {
      return 5;
    } else {
      return 6;
    }
  }
}
