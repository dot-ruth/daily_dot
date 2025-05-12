import 'package:flutter/material.dart';
import 'package:daily_dot/models/app_settings.dart';
import 'package:daily_dot/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /* 
  
  SETUP

  */

  // initialize database 
  static Future<void> initalize() async {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [HabitSchema, AppSettingsSchema], 
        directory: dir.path
        );
  }

  // save first date of app startup ( for heatmap )
  Future<void> saveFirstLaunchDate() async {
    final existingSetting = await isar.appSettings.where().findFirst();
    if(existingSetting == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<void> saveColorSet(Map<int, Color> colorSet) async {
  final existingSettings = await isar.appSettings.where().findFirst();

  final settings = existingSettings ?? AppSettings();

  settings.colorValue1 = colorSet[1]?.value;
  settings.colorValue2 = colorSet[2]?.value;
  settings.colorValue3 = colorSet[3]?.value;
  settings.colorValue4 = colorSet[4]?.value;
  settings.colorValue5 = colorSet[5]?.value;

  await isar.writeTxn(() => isar.appSettings.put(settings));
}

Future<Map<int, Color>> loadColorSet() async {
  final settings = await isar.appSettings.where().findFirst();

  if (settings == null || settings.colorValue1 == null) {
    // default to green shades if not set
    return {
      1: Colors.green.shade200,
      2: Colors.green.shade300,
      3: Colors.green.shade400,
      4: Colors.green.shade500,
      5: Colors.green.shade600,
    };
  }

  return {
    1: Color(settings.colorValue1!),
    2: Color(settings.colorValue2!),
    3: Color(settings.colorValue3!),
    4: Color(settings.colorValue4!),
    5: Color(settings.colorValue5!),
  };
}



  // get first date of app startup ( for heatmap )
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /* 

  CRUD Operation 

  */

  // list of habits
  final List<Habit> currentHabits = [];

  // CREATE - add a new habit
  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = Habit()..name = habitName;

    // save to db 
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
  }

  // READ - read saved habits from db
  Future<void> readHabits() async {
    // fetch all habits from db 
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to local habits list 
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update ui
    notifyListeners();
  }

  // UPDATE - check habit on and off 
  Future<void> updateHabitCompletion( int id, bool isCompleted) async {
    // find the specific habit 
    final habit = await isar.habits.get(id);

    // update completion status 
    if(habit != null){
      await isar.writeTxn(() async {
        // if habit is completed => add the current date to the completedDays List
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
           final today = DateTime.now();
           habit.completedDays.add(DateTime(
            today.year, 
            today.month, 
            today.day
            ));
        }
        // if the habit is not completed, remove the current date form the list 
        else {
           habit.completedDays.removeWhere((date) => 
           date.year == DateTime.now().year &&
           date.month == DateTime.now().month &&
           date.day == DateTime.now().day 
           );
        }

        await isar.habits.put(habit);
      });
      readHabits();
    }
  }

  // UPDATE - edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if(habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        // save updated name to the db
        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

  // DELETE - delete habit 
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
    readHabits();
  }

}