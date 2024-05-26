import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/model/cartModel.dart';

class CartServises {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<CartModel>> getCart() async {
    List<CartModel> cartList = [];
    try {
      final querySnapshot = await firestore
          .collection('CartModel')
          .where('uid', isEqualTo:FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        cartList.add(CartModel.fromMap(doc.data()));
      }
      print("${cartList.length} items found in cart");
      return cartList;
    } catch (e) {
      print("Failed to get cart items: $e");
      return cartList;
    }
  }

  Future<void> addCart(CartModel cartModel, BuildContext context) async {
    final db = FirebaseFirestore.instance;

    try {
      // Query to check if the item is already in the cart
      final querySnapshot = await db
          .collection('CartModel')
          .where('uid', isEqualTo: cartModel.uid)
          .where('pid',
              isEqualTo: cartModel
                  .pid) // Also check the product ID to ensure it's the same item
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Item already in the cart
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item is already in the cart'),
          ),
        );
      } else {
        // Item not in the cart, proceed to add
        String docId = db.collection('CartModel').doc().id;
        await db
            .collection('CartModel')
            .doc(docId)
            .set(cartModel.toMap(), SetOptions(merge: true))
            .then((value) {
          print("Added successfully");
          Navigator.pop(context);
        });
      }
    } catch (e) {
      // Handle any errors here
      print("Failed to add item to cart: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add item to cart'),
        ),
      );
    }
  }
}
