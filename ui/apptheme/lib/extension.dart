import 'package:flutter/material.dart';

extension SuperThemeData on BuildContext {
  TextStyle? get hm => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get lm => Theme.of(this).textTheme.labelMedium;
}
