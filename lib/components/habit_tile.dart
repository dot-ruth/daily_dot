import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final Function(bool?)? onChanged;

  const HabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: ListTile(
          title: Text(text),
          leading: Checkbox(
            value: isCompleted, 
            activeColor: Colors.green,
            onChanged: onChanged),
        ),
      ),
    );
  }
}