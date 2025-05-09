import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  // text controller to access what the user typed in 
  final TextEditingController textController = TextEditingController();

  // create habit method 
  void createNewHabit() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Add a new habit"),
        ),
        actions: [
          //save button
          MaterialButton(onPressed: () {
            String newHabitName = textController.text;

            // save to db
            context.read<HabitDatabase>().addHabit(newHabitName);

            //pop the dialog box
            Navigator.pop(context);

            // clear controller 
            textController.clear();
          },
          child: const Text("Save")
          ),

          // cancle button 
          MaterialButton(onPressed: () {
            // close the dialog box
            Navigator.pop(context);

            // clear the controller 
            textController.clear();
          },
          child: const Text("Cancle")
          )
        ],
      ));
  }

 // check the habit on and off 
  void checkHabitOnOff(bool? value, Habit habit) {

    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id,value);
    }

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Theme.of(context).colorScheme.surface,
       appBar: AppBar(),
       floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: const Icon(Icons.add),
        ),
        body: _buildHabitList(),
    );
  }

  // habit list widget 
  Widget _buildHabitList() {

  // habit db 
  final habitDatabase = context.watch<HabitDatabase>();

  // current habits
  List<Habit> habits = habitDatabase.currentHabits;

  //return list of habits UI
  return ListView.builder(
    itemCount: habits.length,
    itemBuilder: (context, index) {
      // get each habit 
      final habit = habits[index];

      //check if the habit is done today 
      bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

      return HabitTile(
        text: habit.name, 
        isCompleted: isCompletedToday,
        onChanged: (value) => checkHabitOnOff(value, habit)
        );

    });

  

  
  }
    
}