import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:aiplus_to_do/todo/ui/widgets/add_task_fab.dart';
import 'package:aiplus_to_do/todo/ui/widgets/task_filters.dart';
import 'package:aiplus_to_do/todo/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  List<TaskModel> _filterTasks(ToDoState state) {
    switch (state.taskFilterType) {
      case TaskFilterType.completed:
        return state.listOfTasks.where((task) => task.isDone).toList();
      case TaskFilterType.notCompleted:
        return state.listOfTasks.where((task) => !task.isDone).toList();
      default:
        return state.listOfTasks;
    }
  }

  Widget taskScreenList(ToDoState state) {
    if (state.screenStatus == ScreenStatus.initial ||
        state.screenStatus == ScreenStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.screenStatus == ScreenStatus.emptyData) {
      return const Center(child: Text('Добавьте задачу, пока пусто'));
    }
    if (state.screenStatus == ScreenStatus.success) {
      final filteredTasks = _filterTasks(state);
      return ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(taskModel: filteredTasks[index]);
        },
      );
    }

    return const Center(child: Text('Что то пошло не так'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачник'),
      ),
      floatingActionButton: const AddTaskFab(),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          return Column(
            children: [
              const TaskFilters(),
              Expanded(child: taskScreenList(state)),
            ],
          );
        },
      ),
    );
  }
}
