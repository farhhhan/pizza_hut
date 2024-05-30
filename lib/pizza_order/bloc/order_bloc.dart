import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/model/orderModel.dart';
import 'package:pizza_app/utils/orderRepo.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<PizzaOrderAddEvent>(_addOrder);
  }

  FutureOr<void> _addOrder(PizzaOrderAddEvent event, Emitter<OrderState> emit)async {
    emit((PizzaOrderLoadingState()));
    try{
        OrderRepo().addOrderModel(event.orderList, event.context);
        emit(PizzaOrderSucces());
    }catch(e){
      print('getting exception $e');
    }
  }
}
 