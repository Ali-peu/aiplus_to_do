import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskWidget({super.key, required this.taskModel});

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.3, children: [
        SlidableAction(
          onPressed: (context) =>
              context.read<ToDoBloc>().add(DeleteTask(uuid: taskModel.uuid)),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Удалить',
        ),
      ]),
      child: ListTile(
        title: Text(capitalizeFirstLetter(taskModel.taskTitle)),
        trailing: Checkbox(
            value: taskModel.isDone,
            onChanged: (value) {
              if (value != null) {
                context.read<ToDoBloc>().add(ChangeTaskStatus(
                    checkBoxValue: value, uuid: taskModel.uuid));
              }
            }),
      ),
    );
  }
}
