import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskFilters extends StatelessWidget {
  const TaskFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: TaskFilterType.values
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: e == state.taskFilterType
                                  ? WidgetStateProperty.all(Colors.red)
                                  : WidgetStateProperty.all(Colors.white)),
                          onPressed: () {
                            context
                                .read<ToDoBloc>()
                                .add(FilterTasks(taskFilterType: e));
                          },
                          child: Text(
                            getTaskFilterTypeName(e),
                            style: const TextStyle(color: Colors.black),
                          )),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
