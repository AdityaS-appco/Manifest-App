import 'package:flutter/material.dart';
import 'package:manifest/helper/constant.dart';

Divider customDivider({double? thickNess, Color? color}) {
  return Divider(
    color: color ?? mediumGrey,
    thickness: thickNess ?? 1,
  );
}