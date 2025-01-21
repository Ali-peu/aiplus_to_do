part of 'to_do_bloc.dart';

sealed class ToDoEvent {
  const ToDoEvent();
}

final class AddTask extends ToDoEvent {
  final String taskTitle;
  final bool isDone;

  const AddTask({required this.taskTitle, required this.isDone});
}

final class FetchData extends ToDoEvent {
  const FetchData();
}

final class DeleteTask extends ToDoEvent {
  final String uuid;

  const DeleteTask({required this.uuid});
}

final class ChangeTaskStatus extends ToDoEvent {
  final bool checkBoxValue;
  final String uuid;
  


  const ChangeTaskStatus( {required this.checkBoxValue,required this.uuid});
}
