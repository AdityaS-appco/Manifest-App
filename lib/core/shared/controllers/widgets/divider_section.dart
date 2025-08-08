import 'package:flutter/material.dart';
import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';

/// * A widget that adds dividers between its children
class DividerSection extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final EdgeInsets dividerPadding;
  final Color? dividerColor;
  final double dividerThickness;
  final double dividerSpacing;
  final bool isContainered;
  final Color? containerColor;
  final Border? border;
  final BorderRadius? borderRadius;

  const DividerSection({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
    this.dividerPadding = const EdgeInsets.all(16),
    this.dividerColor,
    this.dividerThickness = 1,
    this.dividerSpacing = 16,
    this.isContainered = false,
    this.containerColor,
    this.border,
    this.borderRadius,
  });

  factory DividerSection.containered({
    required List<Widget> children,
    EdgeInsets padding = const EdgeInsets.all(16),
    EdgeInsets dividerPadding = const EdgeInsets.all(16),
    Color? dividerColor,
    double dividerThickness = 1,
    double dividerSpacing = 16,
    Color? containerColor,
    Border? border,
    BorderRadius? borderRadius,
  }) {
    return DividerSection(
      isContainered: true,
      padding: padding.r,
      dividerPadding: dividerPadding.r,
      dividerColor: dividerColor,
      dividerThickness: dividerThickness,
      dividerSpacing: dividerSpacing,
      containerColor: containerColor,
      border: border,
      borderRadius: borderRadius,
      children: children,
    );
  }

  factory DividerSection.containeredForSetting({
    required List<Widget> children,
  }) {
    return DividerSection.containered(
      dividerSpacing: 0,
      padding: EdgeInsets.zero,
      dividerPadding: const EdgeInsets.symmetric(horizontal: 24),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withAlpha(13),
      ),
      children: children,
    );
  }
  @override
  Widget build(BuildContext context) {
    return isContainered
        ? BlurContainer(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            child: _buildContainer(),
          )
        : _buildContainer();
  }

  Container _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        color: containerColor ??
            (isContainered
                ? Colors.white.withOpacity(0.05)
                : Colors.transparent),
        borderRadius: (borderRadius ?? BorderRadius.circular(12)).r,
        border: border,
      ),
      padding: padding.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            ClipRRect(
              /// * cases to handle:
              /// * if there is only 1 tile, all corner rounded
              /// * if more than 1 and first tile, topright, topleft corner rounded
              /// * if more than 1 and last tile, bottomright, bottomleft corner rounded
              borderRadius: ((children.length <= 1 && isContainered)
                      ? borderRadius?.r
                      : (i == 0 && isContainered)
                          ? BorderRadius.only(
                              topRight: borderRadius?.topRight ?? Radius.zero,
                              topLeft: borderRadius?.topLeft ?? Radius.zero).r
                          : (i == children.length - 1 && isContainered)
                              ? BorderRadius.only(
                                  bottomRight:
                                      borderRadius?.bottomRight ?? Radius.zero,
                                  bottomLeft: borderRadius?.bottomLeft ?? Radius.zero)
                              : BorderRadius.zero) ??
                  BorderRadius.zero,
              child: children[i],
            ),
            if (i < children.length - 1) ...[
              dividerSpacing.height,
              Padding(
                padding: dividerPadding.r,
                child: Divider(
                  color: dividerColor ?? AppColors.light.withOpacity(0.05),
                  thickness: dividerThickness.h,
                  height: 0,
                ),
              ),
              dividerSpacing.height,
            ],
          ],
        ],
      ),
    );
  }
}
