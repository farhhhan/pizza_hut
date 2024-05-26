import 'dart:convert';
// Class that will be the Model for a Task Object
class 
CartModel {

 
  String name;
  String description;
  String imageUrl;
  String cate;
  String price;
  String count;
  String size;
  String uid;
  String pid;
  CartModel({ 
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
  String toString() => 'CartModel(id: $uid, name: $name, description: $description)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'description': description,
      'imageUrl':imageUrl,
      'category': cate,
      'price':price,
      'count':count,
      'size':size,
      'pid':pid
    };
  }

  factory 
  CartModel.fromMap(Map<String, dynamic> map) {
    return 
    CartModel(
      pid: map['pid'],
      size: map['size'],
      count: map['count'],
      imageUrl: map['imageUrl'],
      uid: map['uid'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      cate: map['category'] as String,
      price: map['price'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory 
  CartModel.fromJson(String source) =>  CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}