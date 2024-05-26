import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_event.dart';
part 'select_state.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc() : super(SelectState(i: 0)) {
    on<SelectEvent>((event, emit) {
       if(event is SelectChoiceEvent){
        emit(state.copyWith(i: event.select));
       }
    });
  }
}
