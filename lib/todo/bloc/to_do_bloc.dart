import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:aiplus_to_do/todo/repo/shared_pref_local_db.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final SharedPrefLocalDb _sharedPrefLocalDb;
  ToDoBloc({required SharedPrefLocalDb sharedPrefLocalDb})
      : _sharedPrefLocalDb = sharedPrefLocalDb,
        super(const ToDoState()) {
    on<FetchData>((event, emit) async => await _onFetchData(emit));

    on<AddTask>(_addTask);

    on<DeleteTask>((event, emit) => _onDeleteTask(event, emit));

    on<FilterTasks>((event, emit) => _onFilterTasks(event, emit));


    on<ChangeTaskStatus>((event, emit) => _onChangeTaskStatus(event, emit));
  }

    Future<void> _onFilterTasks(FilterTasks  event, Emitter<ToDoState> emit) async {

    emit(state.copyWith( taskFilterType: event.taskFilterType));
  }

  Future<void> _onChangeTaskStatus(
      ChangeTaskStatus event, Emitter<ToDoState> emit) async {
    await _sharedPrefLocalDb.editTaskStatus(
        uuid: event.uuid, isDone: event.checkBoxValue);
    final updatedList = List<TaskModel>.from(state.listOfTasks);
    final data = updatedList.firstWhere((e) => e.uuid == event.uuid);
    final index = updatedList.indexOf(data);

    updatedList[index] = data.copyWith(isDone: event.checkBoxValue);

    emit(state.copyWith(
        screenStatus: ScreenStatus.success, listOfTasks: updatedList));
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<ToDoState> emit) async {
    await _sharedPrefLocalDb.deleteTask(event.uuid);
    final listOffTask = await _sharedPrefLocalDb.getTasks();

    emit(state.copyWith(
        screenStatus: ScreenStatus.success, listOfTasks: listOffTask));
  }

  Future<void> _onFetchData(Emitter<ToDoState> emit) async {
    final data = await _sharedPrefLocalDb.getTasks();
    emit(state.copyWith(
        screenStatus: (data == null || data.isEmpty)
            ? ScreenStatus.emptyData
            : ScreenStatus.success,
        listOfTasks: data));
  }

  Future<void> _addTask(AddTask event, Emitter<ToDoState> emit) async {
    await _sharedPrefLocalDb.addTask(
        taskTitle: event.taskTitle, isDone: event.isDone);
    final listOffTask = await _sharedPrefLocalDb.getTasks();

    emit(state.copyWith(
        screenStatus: ScreenStatus.success, listOfTasks: listOffTask));
  }
}
