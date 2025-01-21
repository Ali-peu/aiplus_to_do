import 'package:aiplus_to_do/app/app.dart';
import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.5, children: [
        SlidableAction(
          spacing: 1,
          onPressed: (context) =>
              context.read<ToDoBloc>().add(DeleteTask(uuid: taskModel.uuid)),
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Удалить',
        ),
      ]),
      child: ListTile(
        title: Text(taskModel.taskTitle),
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
