import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlexibleWrapGrid<T> extends StatelessWidget {
  const FlexibleWrapGrid({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : super(key: key);

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double spacing;
  final double runSpacing;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      physics: physics,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Wrap(
          spacing: spacing.r,
          runSpacing: runSpacing.r,
          children: List.generate(
            items.length,
            (index) => itemBuilder(context, items[index], index),
          ),
        ),
      ),
    );
  }
}
