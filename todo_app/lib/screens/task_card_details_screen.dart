import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/resources/sql_helper.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/utils/globals.dart';

class TaskCardDetailsScreen extends StatefulWidget {
  const TaskCardDetailsScreen({
    super.key,
  });

  static const routeName = '/task-card-details-screen';

  @override
  State<TaskCardDetailsScreen> createState() => _TaskCardDetailsScreenState();
}

class _TaskCardDetailsScreenState extends State<TaskCardDetailsScreen> {
  void _deleteTaskById(int uid) async {
    await SQLHelper().deleteTask(uid);
    setState(() {});
  }

  void _actionMenu(BuildContext context, TaskModel snapshot) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    AddTaskScreen.routeName,
                    arguments: snapshot,
                  );
                },
                leading: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                title: const Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _deleteTaskById(
                    snapshot.uid,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false);
                },
                leading: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TaskModel? snapshot =
        ModalRoute.of(context)!.settings.arguments as TaskModel?;
    final Color? color = categoryColor[snapshot!.category];
    final dateList = snapshot.date.split('-').map((e) => int.parse(e)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          snapshot.category,
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _actionMenu(context, snapshot);
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            color: color,
            child: Image.asset(
              'assets/images/${snapshot.category}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.title,
                    style: const TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${dateList[2]} ${monthMap[dateList[1]]!} ${dateList[0]}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
