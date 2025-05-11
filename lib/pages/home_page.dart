import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_heat_map.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/heatmap_color_bottomsheet.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

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

  //default color set for the heat map
  Map<int, Color> selectedColorSet = {
    1: Colors.green.shade200,
    2: Colors.green.shade300,
    3: Colors.green.shade400,
    4: Colors.green.shade500,
    5: Colors.green.shade600,
  };

  // text controller to access what the user typed in 
  final TextEditingController textController = TextEditingController();

  // create habit method 
  void createNewHabit() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a),
        title:  Text(
        "Add Habit",
        style:  TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
        ),
        content: TextField(
          controller: textController,
          style:  TextStyle( color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
          decoration: const InputDecoration(
            hintText: "Add a new habit"
            
            ),
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
          child: Text(
            "Save",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
          ),

          // cancle button 
          MaterialButton(onPressed: () {
            // close the dialog box
            Navigator.pop(context);

            // clear the controller 
            textController.clear();
          },
          child: Text(
            "Cancle",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
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

// Edit Habit Dialog Boc
  void editHabitDialogBox(Habit habit) {
   textController.text = habit.name;
   showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a),
      title:  Text(
        "Edit Habit",
        style:  TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
        ),
      content: TextField(
        controller: textController,
        style:  TextStyle( color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white)
      ),
      actions: [
          //save button
          MaterialButton(onPressed: () {
            String newHabitName = textController.text;

            // save to db
            context.read<HabitDatabase>().updateHabitName(habit.id,newHabitName);

            //pop the dialog box
            Navigator.pop(context);

            // clear controller 
            textController.clear();
          },
          child: Text(
            "Save",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
          ),

          // cancle button 
          MaterialButton(onPressed: () {
            // close the dialog box
            Navigator.pop(context);

            // clear the controller 
            textController.clear();
          },
          child: Text(
            "Cancle",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
          )
        ],
    ));
  }

  //delete habit 
  void deleteHabitDialogBox(Habit habit) {
   textController.text = habit.name;
   showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a),
      title:  Text(
        "Delete Habit",
        style:  TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
        ),
      content:  Text(
        "Are you sure you want to delete this habit?",
        style:  TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
        ),
      actions: [
          //save button
          MaterialButton(onPressed: () {
           // delete from db
            context.read<HabitDatabase>().deleteHabit(habit.id);

            //pop the dialog box
            Navigator.pop(context);
          },
          child:  Text(
            "Delete",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
          ),

          // cancle button 
          MaterialButton(onPressed: () {
            // close the dialog box
            Navigator.pop(context);
          },
          child: Text(
            "Cancle",
            style: TextStyle(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
            )
          )
        ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        title: const Text("Dot Daily"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showColorPickerBottomSheet, 
            icon: Icon(Icons.settings)), 
          IconButton(
            onPressed: () {
              ThemeProvider.controllerOf(context).nextTheme();
            }, 
            icon: Icon(ThemeProvider.themeOf(context).id == "light_theme" ? Icons.dark_mode_outlined : Icons.wb_sunny_outlined,))
        ],
       ),
       floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor:ThemeProvider.themeOf(context).id == "light_theme" ? Colors.grey[300] : Colors.grey[800],
        child:  Icon(
          Icons.add,
          color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white,
          ),
        ),
        body: ListView(
          children: [
            //heat map 
             _buildHeatMap(),
            // habit list
             _buildHabitList()
          ],
        )
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();

    // get habits
    List<Habit> habits = habitDatabase.currentHabits;

    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(), 
      builder: (context, snapshot) {
           if(snapshot.hasData){
             return HabitHeatMap(
              startDate: snapshot.data!, 
              datasets: prepHeatMapDataset(habits),
              colorsets: selectedColorSet,
              habits: habits,
              );
           }
           else {
            return Container();
           }
      });


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
    // nested list scrolling issue fix
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      // get each habit 
      final habit = habits[index];

      //check if the habit is done today 
      bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

      return HabitTile(
        text: habit.name, 
        isCompleted: isCompletedToday,
        onChanged: (value) => checkHabitOnOff(value, habit),
        editHabit: (context) => editHabitDialogBox(habit),
        deleteHabit: (context) => deleteHabitDialogBox(habit),
        color: selectedColorSet[1]!,
        );

    });

  }

  void _showColorPickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeProvider.themeOf(context).id == "light_theme"
          ? Colors.white
          : Colors.grey[800],
      builder: (BuildContext context) {
        return Container(
          height: 300,
          width: double.infinity,
          child: HeatmapColorBottomsheet(
            onColorSelected: (selected) {
              setState(() {
                selectedColorSet = selected;
              });
            }),
        );
      },
    );
  }
}