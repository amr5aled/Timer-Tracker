import 'dart:ui';

import 'package:flutter/material.dart';

class RasiedButtonSign extends StatelessWidget {
  final double height;
  final VoidCallback onPressed;
  final Color ColorSizeBox;
  final Widget child;
  final double raduis;

  const RasiedButtonSign({Key key, this.height:50.0, this.onPressed, this.ColorSizeBox, this.child,this.raduis:10.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onPressed,
        color: ColorSizeBox,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(raduis)),

        child: child,
      ),
    );
  }
}
