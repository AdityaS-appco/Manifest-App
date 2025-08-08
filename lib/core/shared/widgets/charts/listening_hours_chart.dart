import 'dart:math';
import 'package:manifest/helper/import.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// A chart widget that displays stacked column data for listening hours
/// with morning, afternoon, and night segments
class ListeningHoursChart extends StatelessWidget {
  const ListeningHoursChart({
    Key? key,
    required this.data,
    this.height = 134,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  /// Data for the chart
  final List<DailyListeningData> data;

  /// Height of the chart
  final double height;

  /// Background color of the chart
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: backgroundColor,
      child: SfCartesianChart(
        title: ChartTitle(
          text: "12 h",
          alignment: ChartAlignment.near,
          textStyle: Get.appTextTheme.bodySmall.copyWith(
            height: 1,
            letterSpacing: 0,
            color: Colors.white.withOpacity(0.4),
          ),
        ),
        // Enable panning for scrolling through chart
        enableSideBySideSeriesPlacement: true,
        enableAxisAnimation: false,
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          zoomMode: ZoomMode.x,
        ),

        // Configure margins to match design
        // margin: EdgeInsets.only(left: 12.w, right: 12.w),

        // Make the plot area transparent
        plotAreaBorderWidth: 0,

        // Primary X axis (dates/categories)
        primaryXAxis: CategoryAxis(
          // Hide the axis line
          axisLine: const AxisLine(
            width: 4,
            color: Color(0xff4B4752),
          ),

          // Configure major gridlines to be invisible
          majorGridLines: const MajorGridLines(width: 0),

          // Configure major tick lines to be invisible
          majorTickLines: MajorTickLines(
            size: 8.h,
            width: 2,
            color: const Color(0xFF4B4752),
          ),

          // Label style matching the design
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),

          labelPlacement: LabelPlacement.onTicks,

          // Custom labels for the weeks
          // This is where we'll put the 1-7, 8-15, etc.
          axisLabelFormatter: (AxisLabelRenderDetails args) {
            // Check if the label is a week separator
            if (args.text == 'week_1')
              return ChartAxisLabel('1-7', args.textStyle);
            if (args.text == 'week_2')
              return ChartAxisLabel('8-15', args.textStyle);
            if (args.text == 'week_3')
              return ChartAxisLabel('15-22', args.textStyle);
            if (args.text == 'week_4')
              return ChartAxisLabel('22-30', args.textStyle);
            // Return empty for individual days to hide them
            return ChartAxisLabel('', args.textStyle);
          },

          // Position labels at the bottom
          labelAlignment: LabelAlignment.start,

          // Only show week labels
          interval: 7,
        ),

        // Primary Y axis (values/hours)
        primaryYAxis: NumericAxis(
          name: "12 h",

          // Set minimum and maximum to match the 0-12 hour range
          minimum: 0,
          maximum: 12,

          // Hide the axis line
          axisLine: const AxisLine(
            width: 4,
            color: Color(0xff4B4752),
          ),

          // Configure major gridlines as dashed lines
          majorGridLines: MajorGridLines(
            width: 1,
            color: Colors.white.withOpacity(0.1),
            dashArray: const [5, 5],
          ),

          // Configure labels to be invisible
          labelStyle: const TextStyle(fontSize: 0),

          // Hide tick marks
          majorTickLines: const MajorTickLines(width: 0),

          // Position at the left of the chart
          opposedPosition: false,

          // Interval of 1 hour to create 12 gridlines
          interval: 1,
        ),

        // Series collection
        series: _buildStackedColumnSeries(),
      ),
    );
  }

  /// Build the stacked column series for the chart
  List<StackedColumnSeries<ChartDataPoint, String>>
      _buildStackedColumnSeries() {
    // Apply special grouping for different views
    final List<ChartDataPoint> chartData = _prepareChartData();

    return <StackedColumnSeries<ChartDataPoint, String>>[
      // Morning segment (top - light yellow)
      StackedColumnSeries<ChartDataPoint, String>(
        dataSource: chartData,
        xValueMapper: (ChartDataPoint data, _) => data.x,
        yValueMapper: (ChartDataPoint data, _) => data.morningHours,
        name: 'Morning',
        color: AppColors.chartMorning, // Light yellow
        width: 0.5, // Makes the column thinner (5w)
        spacing: 0.1, // Space between columns (5.5w)
      ),

      // Afternoon segment (middle - light purple)
      StackedColumnSeries<ChartDataPoint, String>(
        dataSource: chartData,
        xValueMapper: (ChartDataPoint data, _) => data.x,
        yValueMapper: (ChartDataPoint data, _) => data.afternoonHours,
        name: 'Afternoon',
        color: AppColors.chartAfternoon, // Light purple
        width: 0.5,
        spacing: 0.1,
      ),

      // Night segment (bottom - light blue)
      StackedColumnSeries<ChartDataPoint, String>(
        dataSource: chartData,
        xValueMapper: (ChartDataPoint data, _) => data.x,
        yValueMapper: (ChartDataPoint data, _) => data.nightHours,
        name: 'Night',
        color: AppColors.chartNight, // Light blue
        width: 0.5,
        spacing: 0.1,
      ),
    ];
  }

  /// Build week separator annotation lines
  List<CartesianChartAnnotation> _buildWeekSeparators() {
    final List<CartesianChartAnnotation> annotations = [];

    // Add separators between weeks
    // We only need to add the vertical lines not at the edges
    for (int i = 1; i < 4; i++) {
      annotations.add(
        CartesianChartAnnotation(
          widget: Container(
            width: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          coordinateUnit: CoordinateUnit.point,
          x: 'day_${i * 7}', // Position at day 7, 14, 21
          y: 0,
        ),
      );
    }

    return annotations;
  }

  /// Prepare data for the chart by grouping days into weeks
  List<ChartDataPoint> _prepareChartData() {
    final List<ChartDataPoint> chartData = [];

    // Special case for year view (12 months)
    if (data.length == 12) {
      for (int i = 0; i < data.length; i++) {
        chartData.add(ChartDataPoint(
          x: 'month_${i + 1}',
          morningHours: data[i].morningHours,
          afternoonHours: data[i].afternoonHours,
          nightHours: data[i].nightHours,
        ));
      }
      return chartData;
    }

    // Add week markers
    chartData.add(ChartDataPoint(
        x: 'week_1', morningHours: 0, afternoonHours: 0, nightHours: 0));
    chartData.add(ChartDataPoint(
        x: 'week_2', morningHours: 0, afternoonHours: 0, nightHours: 0));
    chartData.add(ChartDataPoint(
        x: 'week_3', morningHours: 0, afternoonHours: 0, nightHours: 0));
    chartData.add(ChartDataPoint(
        x: 'week_4', morningHours: 0, afternoonHours: 0, nightHours: 0));

    // Add all days
    for (int i = 0; i < data.length; i++) {
      chartData.add(ChartDataPoint(
        x: 'day_${i + 1}',
        morningHours: data[i].morningHours,
        afternoonHours: data[i].afternoonHours,
        nightHours: data[i].nightHours,
      ));
    }

    return chartData;
  }
}

/// Data point for the chart
class ChartDataPoint {
  final String x;
  final double morningHours;
  final double afternoonHours;
  final double nightHours;

  ChartDataPoint({
    required this.x,
    required this.morningHours,
    required this.afternoonHours,
    required this.nightHours,
  });
}

/// Data model for daily listening statistics
class DailyListeningData {
  final int day;
  final double morningHours;
  final double afternoonHours;
  final double nightHours;

  DailyListeningData({
    required this.day,
    required this.morningHours,
    required this.afternoonHours,
    required this.nightHours,
  });

  /// Total hours for this day
  double get totalHours => morningHours + afternoonHours + nightHours;

  /// Creates a random data point for testing
  factory DailyListeningData.random(int day) {
    final random = Random();
    return DailyListeningData(
      day: day,
      morningHours: random.nextDouble() * 4,
      afternoonHours: random.nextDouble() * 5,
      nightHours: random.nextDouble() * 3,
    );
  }
}
