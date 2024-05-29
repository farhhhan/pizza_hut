// import 'dart:convert';
// // Class that will be the Model for a Task Object
// class 
// OrderModel {

 
//   String name;
//   String description;
//   String imageUrl;
//   String cate;
//   String price;
//   String count;
//   String size;
//   String uid;
//   String pid;
//   String cid;
//   String locationName;
//   String latie;
//   String longe;
//    Map carts;
//   OrderModel({ 
//     required this.carts,
//     required this.locationName,
//     required this.cid,
//     required this.latie,
//    required this.longe,
//     required this.pid,
//     required this.count,
//     required this.size,
//     required this.uid,
//     required this.name,
//    required this.description,
//    required this.imageUrl,
//    required this.price,
//    required this.cate
//   });

//   @override
//   String toString() => 'OrderModel(id: $uid, name: $name, description: $description)';

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'uid': uid,
//       'name': name,
//       'description': description,
//       'imageUrl':imageUrl,
//       'category': cate,
//       'price':price,
//       'count':count,
//       'size':size,
//       'pid':pid,
//       'cid':cid,
//       'cart_items': carts,
//       'longe':longe,
//       'latie':latie,
//       'location':locationName


//     };
//   }

//   factory 
//   OrderModel.fromMap(Map<String, dynamic> map) {
//     return 
//     OrderModel(
//       cid:map['cid'],
//       carts: map['cart_items'],
//       latie: map['latie'],
//       locationName: map['location'],
//       longe: map['longe'],
//       pid: map['pid'],
//       size: map['size'],
//       count: map['count'],
//       imageUrl: map['imageUrl'],
//       uid: map['uid'] as String,
//       name: map['name'] as String,
//       description: map['description'] as String,
//       cate: map['category'] as String,
//       price: map['price'] as String
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory 
//   OrderModel.fromJson(String source) =>  OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }