import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';

class HabitHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> datasets;
  final Map<int, Color> colorsets;
  final List<Habit> habits;

  const HabitHeatMap({
    super.key,
    required this.startDate,
    required this.datasets,
    required this.colorsets,
    required this.habits,
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
      colorsets: colorsets,
      onClick: (date) {
        final normalizeDate = DateTime(date.year, date.month, date.day);

        // Filter habits completed on the clicked date
        final completedHabits = habits
            .where((habit) =>
                habit.completedDays.any((d) =>
                    d.year == normalizeDate.year &&
                    d.month == normalizeDate.month &&
                    d.day == normalizeDate.day))
            .toList();

        // Show dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Habits Completed on ${DateFormat('MMM dd, yyyy').format(normalizeDate)}",
                style: TextStyle(
                  color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white
                ),
                ),
              backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a),
              content: completedHabits.isEmpty
                  ? Text(
                    "No habits completed.",
                    style: TextStyle(
                          fontSize: 18.0,
                          color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white
                          )
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: completedHabits.map((habit) => Text(
                        "• ${habit.name}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white
                          ),

                        )).toList(),
                    ),
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          },
        );
      },
    );
  }
}