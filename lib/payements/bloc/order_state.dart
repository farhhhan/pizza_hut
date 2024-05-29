part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class orderLoadingState extends OrderState{}

class orderSuccesState extends OrderState {
  
}