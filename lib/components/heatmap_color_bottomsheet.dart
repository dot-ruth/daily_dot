import 'package:daily_dot/database/habit_database.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class HeatmapColorBottomsheet extends StatefulWidget {
   final void Function(Map<int, Color>) onColorSelected;

  const HeatmapColorBottomsheet({
    super.key,
    required this.onColorSelected,
    });


  @override
  State<HeatmapColorBottomsheet> createState() => _HeatmapColorBottomsheetState();
}

class _HeatmapColorBottomsheetState extends State<HeatmapColorBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
               Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Base HeatMap Color',
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).id == "light_theme"
                            ? Colors.black
                            : Colors.white,
                    fontSize: 16, 
                    fontWeight: FontWeight.bold),
              ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                            Colors.red,
                            Colors.pink,
                            Colors.purple,
                            Colors.deepPurple,
                            Colors.indigo,
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.cyan,
                            Colors.teal,
                            Colors.green,
                            Colors.lightGreen,
                            Colors.brown,
                            Colors.blueGrey,
                            Colors.grey,
                  ].map((color) {
                    return GestureDetector(
                      onTap: () {
                        final selected = {
                                  1: color.shade200,
                                  2: color.shade300,
                                  3: color.shade400,
                                  4: color.shade500,
                                  5: color.shade600,
                                };
                        widget.onColorSelected(selected);
                        HabitDatabase().saveColorSet(selected);
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 20,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          );
  }
}