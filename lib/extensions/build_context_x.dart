import 'package:flutter/material.dart';

extension BuilContextX on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  Future<T?> pushNamed<T extends Object?>(String routeName) {
    return _navigator.pushNamed(routeName);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(String routeName) {
    return _navigator.pushReplacementNamed(routeName);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(Route<T> newRoute) {
    return _navigator.pushAndRemoveUntil(
      newRoute,
      (route) => false,
    );
  }

  void pop<T extends Object?>([T? result]) {
    return _navigator.pop(result);
  }
}
