part of 'counts_bloc.dart';

sealed class CountsState extends Equatable {
  const CountsState();
  
  @override
  List<Object> get props => [];
}

final class CountsInitial extends CountsState {}
