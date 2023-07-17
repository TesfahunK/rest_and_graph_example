import 'package:flutter/material.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';

class Loader extends StatelessWidget {
  final double strokeWidth;
  final Color? color;
  final double side;

  const Loader({Key? key, this.side = 40, this.color, this.strokeWidth = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: side,
      width: side,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? UiConstants.primaryColor,
      ),
    );
  }
}
