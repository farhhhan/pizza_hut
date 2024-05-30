part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PizzaOrderAddEvent extends OrderEvent {
  OrderModel orderList;
  BuildContext context;
  PizzaOrderAddEvent({required this.orderList,required this.context});
}

class PizzaGetEvent extends OrderEvent {}
