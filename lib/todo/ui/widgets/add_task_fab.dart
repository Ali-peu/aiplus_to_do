import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskFab extends StatefulWidget {
  const AddTaskFab({super.key});

  @override
  State<AddTaskFab> createState() => _AddTaskFabState();
}

class _AddTaskFabState extends State<AddTaskFab> {
  final TextEditingController controller = TextEditingController();

  Future<dynamic> modalBottomSheetForAddTask(
      BuildContext context, ToDoBloc blocValue) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          blocValue.add(AddTask(
                              taskTitle: controller.text, isDone: false));
                          controller.clear();
                        }
                      },
                      icon: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue),
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.yellow,
                          size: 30,
                        ),
                      ))
                ],
              ),
            ),
          );
        }).then((value) {
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          modalBottomSheetForAddTask(context, context.read<ToDoBloc>());
        });
  }
}
