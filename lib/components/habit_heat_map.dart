import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:theme_provider/theme_provider.dart';

class HabitHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> datasets;
  final Map<int, Color> colorsets;

  const HabitHeatMap({
    super.key,
    required this.startDate,
    required this.datasets,
    required this.colorsets,
    });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.grey.shade300 : Colors.grey.shade800,
      textColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorsets: colorsets
    );
  }
}