part of 'to_do_bloc.dart';

sealed class ToDoEvent {
  const ToDoEvent();
}

final class AddTask extends ToDoEvent {
  final String taskTitle;

  AddTask({required this.taskTitle});
}


final class FetchData extends ToDoEvent{
  
}