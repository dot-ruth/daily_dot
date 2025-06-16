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

int calculateLongestStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  final dates = completedDays
      .map((d) => DateTime(d.year, d.month, d.day))
      .toSet()
      .toList()
    ..sort();

  int longest = 1;
  int current = 1;

  for (int i = 1; i < dates.length; i++) {
    final prev = dates[i - 1];
    final curr = dates[i];

    if (curr.difference(prev).inDays == 1) {
      current += 1;
      longest = current > longest ? current : longest;
    } else if (curr != prev) {
      current = 1;
    }
  }

  return longest;
}

int calculateCurrentStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) return 0;

  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final completed = completedDays
      .map((d) => DateTime(d.year, d.month, d.day))
      .toSet();

  int streak = 0;
  DateTime date = todayDate;

  while (completed.contains(date)) {
    streak += 1;
    date = date.subtract(Duration(days: 1));
  }

  return streak;
}
