import 'package:flutter/material.dart';

class XButton extends ElevatedButton{
  XButton({
    super.key,
    String text = "",
    Widget? child,
    double? fontSize,
    FontWeight? fontWeight,
    double radius = 0,
    bool transparent = false,
    Color? background,
    Color? foreground,
    void Function()? onPressed
  }) : super(
    child: child ?? Text(text, style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      )
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: foreground,
      backgroundColor: transparent ? Colors.transparent : background,
      shadowColor: transparent ? Colors.transparent : null,
      elevation: transparent ? 0 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    onPressed: onPressed,
  );
}