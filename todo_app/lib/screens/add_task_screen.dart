import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/resources/sql_helper.dart';
import 'package:todo_app/widgets/task_category.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const routeName = '/add-task-screen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? pickedDate;
  DateTime? currentDate;
  String category = 'Work';
  TimeOfDay? pickedTime;
  TimeOfDay? pickedTime24;
  String _date = 'Date';
  String _time = 'Time';
  String _time24 = 'Time 24';

  void _addTask() async {
    final int uid = DateTime.now().millisecondsSinceEpoch;
    final String enteredTitle = _titleController.text;
    final String enteredDescription = _descriptionController.text;
    final String enteredCategory = category;
    final String enteredDate = _date == 'Date'
        ? DateTime.now().toIso8601String().substring(0, 10)
        : _date;
    final String enteredTime = _time == 'Time'
        ? DateTime.now().toIso8601String().substring(11, 16)
        : _time;
    final String enteredTime24 = _time24 == 'Time 24'
        ? DateTime.now().toIso8601String().substring(11, 16)
        : _time24;
    final String enteredTimeOfCreation = DateTime.now().toIso8601String();
    const enteredIsDone = false;

    // print all the values
    print('uid: $uid');
    print('title: $enteredTitle');
    print('description: $enteredDescription');
    print('category: $enteredCategory');
    print('date: $enteredDate');
    print('time: $enteredTime');
    print('time24: $enteredTime24');
    print('timeOfCreation: $enteredTimeOfCreation');
    print('isDone: $enteredIsDone');

    if (enteredTitle.isEmpty ||
        enteredDescription.isEmpty ||
        enteredDate.isNotEmpty ||
        enteredTime.isNotEmpty) {
      TaskModel taskModel = TaskModel(
        uid: uid,
        title: enteredTitle,
        description: enteredDescription,
        category: enteredCategory,
        date: enteredDate,
        time: enteredTime,
        time24: enteredTime24,
        timeOfCreation: enteredTimeOfCreation,
        isDone: enteredIsDone,
      );

      await SQLHelper().insertTask(taskModel);
    }
  }

  void _pickDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    currentDate = DateTime.now();
    setState(() {
      _date = pickedDate!.toIso8601String().substring(0, 10);
    });
  }

  void _pickTime(BuildContext context) async {
    pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    // pickedTime to 24 hours format
    pickedTime24 = TimeOfDay(
      hour: pickedTime!.hour,
      minute: pickedTime!.minute,
    );

    setState(() {
      _time = pickedTime!.format(context);
      _time24 = pickedTime24!.toString().substring(10, 15);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaskModel? args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    int uid = args.uid;
    String titleEdit = args.title;
    String descriptionEdit = args.description;
    String categoryEdit = args.category;
    String dateEdit = args.date;
    String timeEdit = args.time;
    String time24Edit = args.time24;
    String nCategory = categoryEdit.isEmpty ? category : categoryEdit;
    String _nDate = dateEdit.isEmpty ? _date : dateEdit;
    String _nTime = timeEdit.isEmpty ? _time : timeEdit;
    String _nTime24 = time24Edit.isEmpty ? _time24 : time24Edit;

    _titleController.text =
        titleEdit.isEmpty ? _titleController.text : titleEdit;
    _descriptionController.text = descriptionEdit.isEmpty
        ? _descriptionController.text
        : descriptionEdit;

    if (category != nCategory) {
      category = nCategory;
    }

    if (_date != _nDate) {
      _date = _nDate;
    }

    if (_time != _nTime) {
      _time = _nTime;
    }

    if (_time24 != _nTime24) {
      _time24 = _nTime24;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        actions: [
          IconButton(
            onPressed: () {
              _addTask();
              SQLHelper().deleteTask(uid);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TaskCategory(
                selectedCategory: (value) {
                  setState(() {
                    category = value;
                  });
                },
                initialCategory: nCategory,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                // vertical: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignLabelWithHint: true,
                      labelText: 'Description',
                    ),
                  ),

                  //Date picker
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _date,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _pickDate(context);
                          },
                          child: const Text(
                            'Choose date',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Time picker
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _time,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _pickTime(context);
                          },
                          child: const Text(
                            'Choose time',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
