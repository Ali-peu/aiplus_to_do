part of 'to_do_bloc.dart';

enum ScreenStatus { initial, loading, success, failure }

class ToDoState extends Equatable {
  final ScreenStatus screenStatus;
  final List<TaskModel> listOfTasks;
  const ToDoState(
      {this.screenStatus = ScreenStatus.initial, this.listOfTasks = const []});

  @override
  List<Object> get props => [screenStatus, listOfTasks];
}
