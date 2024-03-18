import 'package:flutter/material.dart';

import 'app_color.dart';
import 'mediaQuery.dart';

Container customDevider() {
  return Container(
    width: double.infinity,
    height: SizeConfig.Height * 0.001,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.transparent,
        AppColors.grey.withOpacity(0.5),
        Colors.transparent
      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
    ),
  );
}

Widget customContainer(
    {margin,
    onTap,
    double? borderRadius,
    padding,
    bgColor,
    Color? borderColor,
    child}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.backgroundblueColour,
        border: Border.all(
          color: borderColor ?? Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    ),
  );
}
