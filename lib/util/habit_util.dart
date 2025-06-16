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

String getRandomTitle() {
  final titles = [
    "Time to shine ✨",
    "Dot your day!",
    "Let’s build that streak 💪",
    "Another day, another dot 🟢",
  ];
  return titles[randomIndex(titles.length)];
}

String getRandomBody() {
  final messages = [
    "Your future self is proud! Go tick off your habits 📅",
    "Don’t break the chain! 🔗",
    "Just 30 seconds to feel accomplished 🎉",
    "Consistency beats motivation. Let’s go!",
  ];
  return messages[randomIndex(messages.length)];
}

int randomIndex(int length) => DateTime.now().second % length;