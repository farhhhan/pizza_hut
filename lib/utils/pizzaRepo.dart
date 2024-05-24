import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/model/pizzamodel.dart';

class PizzaServiese{
   final FirebaseFirestore firestore=FirebaseFirestore.instance;
   Future<List<Pizza>> getPizza() async {
    List<Pizza> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('pizza').get();
      datas.docs.forEach((element) { 
        print(element.data());
        packageList.add(Pizza.fromMap(element.data()));
      });
      print("${packageList.length} is lenght      ");
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
}