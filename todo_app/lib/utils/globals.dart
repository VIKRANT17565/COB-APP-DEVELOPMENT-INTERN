import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';

// categories list
final List<String> categories = [
  'Work',
  'Fun',
  'Sports',
  'Family',
  'Other',
];

// Color codes for categories
final Map<String, Color> categoryColor = {
  'Work': Colors.blue,
  'Fun': Colors.purple,
  'Sports': Colors.green,
  'Family': Colors.red,
  'Other': Colors.orange,
};
// month map
final Map<int, String> monthMap = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

// TaskModel null object
final TaskModel nullTaskModel = TaskModel(
  uid: 0,
  title: '',
  description: '',
  category: '',
  date: '',
  time: '',
  time24: '',
  timeOfCreation: '',
  isDone: false,
);
