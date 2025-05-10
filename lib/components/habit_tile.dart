import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:theme_provider/theme_provider.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? editHabit;
  final Function(BuildContext)? deleteHabit;

  const HabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), 
          children: [
            //edit button 
            SlidableAction(
              onPressed: editHabit,
              foregroundColor: Colors.blue, 
              backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a), 
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8)
              ),
      
              //delete button 
            SlidableAction(
              onPressed: deleteHabit,
              foregroundColor: Colors.red, 
              backgroundColor: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.white : Color(0xff0a0a0a), 
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8)
              )
          ]),
        child: GestureDetector(
          onTap: () {
            if(onChanged != null ){
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                 ? Colors.green
                 :ThemeProvider.themeOf(context).id == "light_theme" ? Colors.grey[300] : Colors.grey[800] ,
              borderRadius: BorderRadius.circular(8)
            ),
            padding: const EdgeInsets.all(12),
            // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(color:  ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
                ),
              leading: Checkbox(
                value: isCompleted, 
                activeColor: Colors.green,
                side: BorderSide(color: ThemeProvider.themeOf(context).id == "light_theme" ? Colors.black : Colors.white),
                onChanged: onChanged),
            ),
          ),
        ),
      ),
    );
  }
}