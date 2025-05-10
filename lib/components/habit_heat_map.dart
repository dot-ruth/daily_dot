import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:theme_provider/theme_provider.dart';

class HabitHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> datasets;

  const HabitHeatMap({
    super.key,
    required this.startDate,
    required this.datasets,
    });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.grey[300] : Colors.grey[800],
      textColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}