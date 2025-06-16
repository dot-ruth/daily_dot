import 'package:daily_dot/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
 DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 300,
           child:
            CupertinoTheme(
              data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: ThemeProvider.themeOf(context).id == "light_theme"? Colors.black: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: _selectedTime,
                onDateTimeChanged: (DateTime newTime) {
                  setState(() {
                    _selectedTime = newTime;
                  });
              
                },
              ),
            ),
            
          ),
           const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                  NotificationService().scheduleDailyNotification(
                    hour:_selectedTime.hour,
                    minute:_selectedTime.minute
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Notification scheduled successfully',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.grey.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        duration: const Duration(seconds: 3),
                        dismissDirection: DismissDirection.up,
                        showCloseIcon: true,
                        closeIconColor: Colors.white,
                      ),
                    );

              } ,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
