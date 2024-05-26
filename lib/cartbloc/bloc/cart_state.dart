part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

final class CartAddLoadingEvent extends CartState {}

class CartAddedSuccesState extends CartState {
  CartModel cart;
  CartAddedSuccesState({required this.cart});
  @override
  List<Object> get props => [cart];
}
class GetCartState extends CartState {
  List<CartModel> cart;
  GetCartState({required this.cart});
  @override
  List<Object> get props => [cart];
}