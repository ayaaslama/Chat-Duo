import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(
    String routeName, {
    String? arguments,
  }) {
    return Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pop() => Navigator.of(this).pop();
}
