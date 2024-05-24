part of 'pizzaadd_bloc.dart';

sealed class PizzaaddEvent extends Equatable {
  const PizzaaddEvent();

  @override
  List<Object> get props => [];
}

class GetPizzaEvent extends PizzaaddEvent{}