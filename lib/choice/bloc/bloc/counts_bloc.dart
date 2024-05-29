import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counts_event.dart';
part 'counts_state.dart';

class CountsBloc extends Bloc<CountsEvent, CountsState> {
  CountsBloc() : super(CountsInitial()) {
    on<CountsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
