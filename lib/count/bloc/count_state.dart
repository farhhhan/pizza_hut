part of 'count_bloc.dart';

class CountState extends Equatable {
  final Map<String, int> counts;

  const CountState({required this.counts});

  @override
  List<Object> get props => [counts];
}
