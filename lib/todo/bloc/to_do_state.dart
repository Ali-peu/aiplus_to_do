part of 'to_do_bloc.dart';

enum ScreenStatus { initial, emptyData, loading, success }

enum TaskFilterType { all, completed, notCompleted }


String getTaskFilterTypeName(TaskFilterType taskFilterType ){
  switch(taskFilterType){
    case TaskFilterType.all:
     return 'Все';
     case TaskFilterType.completed:
     return 'Выполненные';
     case TaskFilterType.notCompleted:
     return 'Не выполненные';
  }
}

class ToDoState extends Equatable {
  final ScreenStatus screenStatus;
  final List<TaskModel> listOfTasks;
  final TaskFilterType taskFilterType;
  const ToDoState(
      {this.screenStatus = ScreenStatus.initial,
      this.listOfTasks = const [],
      this.taskFilterType = TaskFilterType.all});

  ToDoState copyWith(
      {ScreenStatus? screenStatus,
      List<TaskModel>? listOfTasks,
      TaskFilterType? taskFilterType}) {
    return ToDoState(
        screenStatus: screenStatus ?? this.screenStatus,
        listOfTasks: listOfTasks ?? this.listOfTasks,
        taskFilterType: taskFilterType ?? this.taskFilterType);
  }

  @override
  List<Object> get props => [screenStatus, listOfTasks, taskFilterType];
}
