import 'package:aiplus_to_do/todo/domain/model/task_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const ToDoState()) {
    on<FetchData>((event, emit) {
      
    });

    on<AddTask>((event, emit) {});
  }
}
