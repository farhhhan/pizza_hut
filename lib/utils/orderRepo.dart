import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/home.dart';
import 'package:pizza_app/model/orderModel.dart';

class OrderRepo {
  Future<List<OrderModel>> getOrderModel() async {
    List<OrderModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance.collection('orders').get();
      datas.docs.forEach((element) {
        print(element.data());
        packageList.add(OrderModel.fromMap(element.data()));
      });
      print("${packageList.length} is lenght      ");
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }

  Future<void> addOrderModel(
      OrderModel OrderModel, BuildContext context) async {
    final db = FirebaseFirestore.instance;
    String uid = db.collection('orders').doc().id;
    OrderModel.uid = uid;
    print(OrderModel.uid);
     
    print(OrderModel.toMap());
    await db
        .collection("orders")
        .doc(uid)
        .set(OrderModel.toMap(), SetOptions(merge: true))
        .then((value) {
      print("added succesfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    });
  }
}
