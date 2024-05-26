part of 'count_bloc.dart';

abstract class CountEvent extends Equatable {
  const CountEvent();

  @override
  List<Object> get props => [];
}

class IncreaseEvent extends CountEvent {
  final String pid;

  const IncreaseEvent(this.pid);

  @override
  List<Object> get props => [pid];
}

class DecreaseEvent extends CountEvent {
  final String pid;

  const DecreaseEvent(this.pid);

  @override
  List<Object> get props => [pid];
}
