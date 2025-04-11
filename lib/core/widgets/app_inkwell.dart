import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppInkWell({required Widget child, required VoidCallback? onTap}) {
  return Material(
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: child,
    ),
  );
}
