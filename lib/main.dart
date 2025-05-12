import 'package:flutter/material.dart';
import 'package:daily_dot/database/habit_database.dart';
import 'package:daily_dot/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // intialize database 
 await HabitDatabase.initalize();
 await HabitDatabase().saveFirstLaunchDate();
  runApp(
    ChangeNotifierProvider(
      create: (context) => HabitDatabase(),
      child: const MyApp(),
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var darkGreyColor = Color(0xff0a0a0a);
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      defaultThemeId: "dark_theme",
      themes: [
        AppTheme(
          id: "light_theme", 
          data: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white
            ),
            iconTheme: const IconThemeData(
              color: Colors.black
            ),

          ), 
          description: "light_theme"
          ),
          AppTheme(
          id: "dark_theme", 
          data: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: darkGreyColor,
            
            appBarTheme: AppBarTheme(
              backgroundColor: darkGreyColor,
              iconTheme: IconThemeData(
                color: Colors.grey[500]
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22
              )
            ),
          ), 
          description: "dark_theme"
          ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          ))
        )
      );
  }
}
