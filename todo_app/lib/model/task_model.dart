class TaskModel {
  final int uid;
  final String title;
  final String description;
  final String category;
  final String date;
  final String time;
  final String time24;
  final String timeOfCreation;
  bool isDone;

  TaskModel({
    required this.uid,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.time24,
    required this.timeOfCreation,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'time24': time24,
      'timeOfCreation': timeOfCreation,
      'isDone': isDone ? 1 : 0,
    };
  }
}
