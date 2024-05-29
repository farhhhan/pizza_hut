import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/cartbloc/cartRepo.dart';
import 'package:pizza_app/model/cartModel.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartAddEvent>(_cartAdd);
    on<GetCartEvent>(_getCart);
  }

  FutureOr<void> _cartAdd(CartAddEvent event, Emitter<CartState> emit) async {
    emit(CartAddLoadingEvent());
    Future.delayed(Duration(seconds: 2));
    try {
      var cart = CartModel(
          pid: event.pid,
          count: event.count,
          size: '',
          uid: event.uid,
          name: event.name,
          description: event.description,
          imageUrl: event.imageUrl,
          price: event.price,
          cate: event.cate);
      CartServises().addCart(cart, event.context);
      emit(CartAddedSuccesState(cart: cart));
    } catch (e) {
      print("Excpetion$e");
    }
  }

  FutureOr<void> _getCart(GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartAddLoadingEvent());
    try {
      var lists = await CartServises().getCart();
      emit(GetCartState(cart: lists));
    } catch (e) {
      print("Excpetion$e");
    }
  }
}
