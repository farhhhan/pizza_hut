import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_event.dart';
part 'count_state.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  CountBloc() : super(CountState(counts: {})) {
    on<IncreaseEvent>(_increase);
    on<DecreaseEvent>(_decrease);
  }

  FutureOr<void> _increase(IncreaseEvent event, Emitter<CountState> emit) {
    final newCounts = Map<String, int>.from(state.counts);
    newCounts[event.pid] = (newCounts[event.pid] ?? 1) + 1;
    emit(CountState(counts: newCounts));
  }

  FutureOr<void> _decrease(DecreaseEvent event, Emitter<CountState> emit) {
    final newCounts = Map<String, int>.from(state.counts);
    if (newCounts[event.pid] != null && newCounts[event.pid]! > 1) {
      newCounts[event.pid] = newCounts[event.pid]! - 1;
      emit(CountState(counts: newCounts));
    }
  }
}
