import 'package:flutter/material.dart';

enum FibonacciType { circle, square, cross }

class Fibonacci {
  final int index;
  final BigInt number;
  final FibonacciType? type;
  bool show;

  Fibonacci(this.index, this.number, this.type, {this.show = true});

  static Widget getIconByType(FibonacciType? type) {
    switch (type) {

      case FibonacciType.circle:
    return Icon(Icons.circle);

      case FibonacciType.square:
    return Icon(Icons.square_outlined);

      case FibonacciType.cross:
        return Icon(Icons.close);
      default:
        return SizedBox();
    }
  }
}
