import 'package:flutter/material.dart';

extension NumX on num {
  SizedBox get w => SizedBox(width: this as double);
  SizedBox get h => SizedBox(height: this as double);
}
