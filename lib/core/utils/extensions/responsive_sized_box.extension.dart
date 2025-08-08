import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveSizedBox on num {
  SizedBox get height => SizedBox(height: toDouble().h);
  SizedBox get width => SizedBox(width: toDouble().w);
}
