// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class YMargin extends StatelessWidget {
  double y;
   YMargin({super.key, required this.y});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: y,
    );
  }
}

class XMargin extends StatelessWidget {
  double x;
   XMargin({super.key, required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: x,
    );
  }
}