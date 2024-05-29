part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class CartAddEvent extends CartEvent{
  String name;
  String description;
  String imageUrl;
  String cate;
  String price;
  int count;
  String size;
  String uid;
  String pid;
  BuildContext context;
  CartAddEvent({ 
    required this.context,
    required this.pid,
    required this.count,
    required this.size,
    required this.uid,
    required this.name,
   required this.description,
   required this.imageUrl,
   required this.price,
   required this.cate
  });
  @override
  List<Object> get props => [name,description,imageUrl,cate,price,count,size,uid,pid];

}
class GetCartEvent extends CartEvent {}