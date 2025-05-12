// given a habit list of completion days , is the habit completed today
//

import 'package:daily_dot/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) => 
  date.year == today.year &&
  date.month == today.month &&
  date.day == today.day
);
}


// prepare the heat map data set 
Map<DateTime, int> prepHeatMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (Habit habit in habits) {
    for (DateTime date in habit.completedDays) {
        final normalizeDate = DateTime(date.year, date.month, date.day);
        if (dataset.containsKey(normalizeDate)) {
          dataset[normalizeDate] = dataset[normalizeDate]! + 1;
        } else {
          dataset[normalizeDate] = 1;
        }
    }
   }
   return dataset;
}


 