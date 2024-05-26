part of 'pizzaadd_bloc.dart';

sealed class PizzaaddState extends Equatable {
  const PizzaaddState();
  
  @override
  List<Object> get props => [];
}

final class PizzaaddInitial extends PizzaaddState {}

class PizzaGetSucces extends PizzaaddState{
  List<Pizza>? pizzaList;
  PizzaGetSucces({required this.pizzaList});
  @override
  List<Object> get props => [pizzaList!];
}


