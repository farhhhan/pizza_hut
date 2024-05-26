part of 'select_bloc.dart';

class SelectState extends Equatable {
  int i;
  SelectState({required this.i});

  @override
  List<Object> get props => [i];

  SelectState copyWith({int? i}) {
    return SelectState(i: i ?? this.i);
  }
}
