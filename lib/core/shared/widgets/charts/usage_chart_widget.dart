import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/charts/listening_hours_chart.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/duration_selection_cupertino_tabbar.dart';

class UsageChartWidget extends StatelessWidget {
  const UsageChartWidget({
    Key? key,
    required this.timePeriod,
    this.height = 150,
  }) : super(key: key);

  /// Current selected time period (day, week, month)
  final Rx<TimePeriod> timePeriod;

  /// Height of the chart
  final double height;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Generate appropriate data based on selected time period
      final chartData = _generateChartData(timePeriod.value);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height.h,
            child: ListeningHoursChart(
              data: chartData,
              height: height,
            ),
          ),

          24.height,
          // Time period legend
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTimePeriodColumn(
                iconPath: IconAllConstants.sun,
                color: AppColors.chartMorning,
                period: 'Morning',
                time: '6AM-12PM',
              ),
              35.width,
              _buildTimePeriodColumn(
                iconPath: IconAllConstants.sunSetting02,
                color: AppColors.chartAfternoon,
                period: 'Afternoon',
                time: '12PM-21PM',
              ),
              35.width,
              _buildTimePeriodColumn(
                iconPath: IconAllConstants.moon02,
                color: AppColors.chartNight,
                period: 'Night',
                time: '21PM-6AM',
              ),
            ],
          ),
        ],
      );
    });
  }

  /// Builds a legend item for the time period
  Widget _buildTimePeriodColumn({
    required String iconPath,
    required Color color,
    required String period,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          height: 16,
          width: 16,
          color: color,
        ),
        5.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              period,
              style: Get.appTextTheme.bodyMedium.copyWith(
                color: color,
                letterSpacing: 0,
                height: 1.29,
              ),
            ),
            Text(
              time,
              style: Get.appTextTheme.bodyTiny.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Generates chart data based on the selected time period
  List<DailyListeningData> _generateChartData(TimePeriod period) {
    switch (period) {
      case TimePeriod.day:
        // Generate data for a single day (24 hours)
        return List.generate(
            24, (index) => DailyListeningData.random(index + 1));

      case TimePeriod.week:
        // Generate data for a week (7 days)
        return List.generate(
            7, (index) => DailyListeningData.random(index + 1));

      case TimePeriod.month:
        // Generate data for a full month (30 or 31 days)
        final daysInMonth = DateTime.now().month == 2
            ? (DateTime.now().year % 4 == 0 ? 29 : 28)
            : [4, 6, 9, 11].contains(DateTime.now().month)
                ? 30
                : 31;

        return List.generate(
            daysInMonth, (index) => DailyListeningData.random(index + 1));

      case TimePeriod.year:
        // Generate data for a full year (12 months)
        // For year view, we'll use monthly data points instead of daily
        return List.generate(12, (index) {
          // Get the month name (Jan, Feb, etc.)
          final monthName = _getMonthAbbreviation(index + 1);

          // Create data for this month with the day field representing the month number
          return DailyListeningData(
            day: index + 1,
            morningHours: _getAverageMonthlyHours(index + 1, 'morning'),
            afternoonHours: _getAverageMonthlyHours(index + 1, 'afternoon'),
            nightHours: _getAverageMonthlyHours(index + 1, 'night'),
          );
        });
    }
  }

  /// Returns the abbreviated month name for a given month number
  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  /// Generates consistent "random" data for monthly averages
  double _getAverageMonthlyHours(int month, String timeOfDay) {
    // Using a deterministic approach to generate consistent data
    // based on the month number and time of day
    final seed = month * (timeOfDay.hashCode);
    final baseValue = ((seed % 7) + 1) / 2; // Between 0.5 and 4.0

    switch (timeOfDay) {
      case 'morning':
        return baseValue + 1.0; // Morning hours slightly higher
      case 'afternoon':
        return baseValue + 1.5; // Afternoon hours highest
      case 'night':
        return baseValue * 0.8; // Night hours lower
      default:
        return baseValue;
    }
  }
}
