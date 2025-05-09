import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8)
              ),
      
              //delete button 
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red.shade800,
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
                 :Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8)
            ),
            padding: const EdgeInsets.all(12),
            // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(color: Colors.white ),
                ),
              leading: Checkbox(
                value: isCompleted, 
                activeColor: Colors.green,
                onChanged: onChanged),
            ),
          ),
        ),
      ),
    );
  }
}