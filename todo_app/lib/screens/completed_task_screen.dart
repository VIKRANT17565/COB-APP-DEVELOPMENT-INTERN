import 'package:flutter/material.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/resources/sql_helper.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/task_card_details_screen.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/widgets/todo_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  static const routeName = '/completed-task-screen';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  void _deleteTaskById(int uid) async {
    await SQLHelper().deleteTask(uid);
  }

  void _deleteAllTasks() async {
    await SQLHelper().deleteAllTasks(isDone: 1);
  }

  void _actionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AddTaskScreen.routeName,
                    arguments: nullTaskModel,
                  );
                },
                leading: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                title: const Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _deleteAllTasks();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false);
                },
                leading: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                title: const Text(
                  'Delete All Tasks',
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Tasks'),
          actions: [
            IconButton(
              onPressed: () {
                _actionMenu(context);
              },
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: SQLHelper().getTasks(isDone: 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text('Error'),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Todo list is empty',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      TaskCardDetailsScreen.routeName,
                      arguments: snapshot.data![index],
                    );
                  },
                  child: Dismissible(
                    onDismissed: (direction) {
                        TaskModel tempTask = snapshot.data![index];
                        _deleteTaskById(snapshot.data![index].uid);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Task is deleted',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                print('undo');
                                SQLHelper().insertTask(tempTask);
                                setState(() {});
                                return;
                              },
                            ),
                          ),
                        );
                    },
                    key: Key(snapshot.data![index].uid.toString()),
                    child: TodoCard(
                      title: snapshot.data![index].title,
                      description: snapshot.data![index].description,
                      date: snapshot.data![index].date,
                      category: snapshot.data![index].category,
                      time: snapshot.data![index].time,
                      timeOfCreation: snapshot.data![index].timeOfCreation,
                      isDone: snapshot.data![index].isDone,
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddTaskScreen.routeName,
              arguments: TaskModel(
                uid: 0,
                title: '',
                description: '',
                date: '',
                category: '',
                time: '',
                time24: '',
                timeOfCreation: '',
                isDone: false,
              ),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ));
  }
}
