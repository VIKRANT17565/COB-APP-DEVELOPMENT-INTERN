import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/completed_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/task_card_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/Work.jpg'), context);
    precacheImage(const AssetImage('assets/images/Fun.jpg'), context);
    precacheImage(const AssetImage('assets/images/Family.jpg'), context);
    precacheImage(const AssetImage('assets/images/Sports.jpg'), context);
    precacheImage(const AssetImage('assets/images/Other.jpg'), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddTaskScreen.routeName: (context) => const AddTaskScreen(),
        TaskCardDetailsScreen.routeName: (context) =>
            const TaskCardDetailsScreen(),
            CompletedTaskScreen.routeName: (context) => const CompletedTaskScreen(),
      },
      title: 'To DO App',
    );
  }
}
