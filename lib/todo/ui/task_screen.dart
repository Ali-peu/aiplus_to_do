import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:aiplus_to_do/todo/ui/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController controller = TextEditingController();

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
                        blocValue.add(
                            AddTask(taskTitle: controller.text, isDone: false));
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
        });
  }

  @override
  Widget build(BuildContext context) {
    final blocValue = context.read<ToDoBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачник'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () {
            modalBottomSheetForAddTask(context, blocValue);
          }),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: TaskFilterType.values
                    .map((e) => TextButton(
                        onPressed: () {
                          context
                              .read<ToDoBloc>()
                              .add(FilterTasks(taskFilterType: e));
                        },
                        child: Text(e.name)))
                    .toList(),
              ),
              Expanded(child: taskScreenList(state)),
            ],
          );
        },
      ),
    );
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
}
