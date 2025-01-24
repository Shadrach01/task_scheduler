/*

SCREEN SIZE BUILT ON THE CONTEXT DIRECTLY

 */

import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  double get appHeight => MediaQuery.of(this).size.height;
  double get appWidth => MediaQuery.of(this).size.width;
}
