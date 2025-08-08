import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget showSvgIconWidget({required String iconPath, Function()? onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(iconPath,));
}