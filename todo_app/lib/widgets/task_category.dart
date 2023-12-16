import 'package:flutter/material.dart';
import 'package:todo_app/utils/globals.dart';

class TaskCategory extends StatefulWidget {
  final Function selectedCategory;
  final String initialCategory;
  const TaskCategory({
    super.key,
    required this.selectedCategory,
    required this.initialCategory,
  });

  @override
  State<TaskCategory> createState() => _TaskCategoryState();
}

class _TaskCategoryState extends State<TaskCategory> {
  final List<String> _categories = categories;

  // get selectedCategory => _selectedCategory;

  @override
  Widget build(BuildContext context) {
  String selectedCategory = widget.initialCategory;
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedCategory = _categories[index];
                widget.selectedCategory(selectedCategory);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: selectedCategory == _categories[index]
                    ? Colors.amber
                    : Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
