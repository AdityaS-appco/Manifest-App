
import 'package:manifest/helper/import.dart';

class PillTabBar extends StatelessWidget {
  const PillTabBar({
    required this.controller,
    required this.tabs,
    this.activeTabTextStyle,
    this.inactiveTabTextStyle,
    this.padding = 3,
    this.height = 45,
    this.width = double.infinity,
  });
  final TabController controller;
  final List<Tab> tabs;
  final TextStyle? activeTabTextStyle;
  final TextStyle? inactiveTabTextStyle;
  final double padding;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColors.light.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: TabBar(
        dividerHeight: 0,
        padding: EdgeInsets.all(padding).r,
        controller: controller,
        labelColor: AppColors.light,
        unselectedLabelColor: Colors.white.withOpacity(0.8),
        indicator: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle:
            activeTabTextStyle ?? Get.appTextTheme.pillActiveTabTextLarge,
        unselectedLabelStyle:
            inactiveTabTextStyle ?? Get.appTextTheme.pillInactiveTabTextLarge,
        tabs: tabs,
      ),
    );
  }
}