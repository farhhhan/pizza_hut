import 'dart:convert';


// Class that will be the Model for a Task Object
class OrderModel {
  String name;
  String locationName;
  double latie;
  double longe;
  double totalprice;
  int count;
  String uid;
  String dpid;
 List< Map<String,dynamic>> items;
  String uuid;
  String deliveryPrice;

  OrderModel({
    required this.deliveryPrice,
    required this.uuid,
    required this.latie,
    required this.longe,
    required this.locationName,
    required this.dpid,
    required this.count,
    required this.items,
    required this.uid,
    required this.name,
    required this.totalprice,
  });

  @override
  String toString() => 'OrderModel(id: $uid, name: $name, )';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'd_price':deliveryPrice,
      'uid': uid,
      'uuid': uuid,
      'name': name,
      'totalprice': totalprice,
      'count': count,
      'items': items,
      'dpid': dpid,
      'latie': latie,
      'longe': longe,
      'clint_location': locationName,
      'deliveryboy_location': '',
      'd_latie': 0.000,
      "d_longe": 0.000,
      'accepted': false,
      'd_uid': '',
      'status':'pending'
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      deliveryPrice: map['d_price'],
        uuid: map['u_uid'],
        latie: map['latie'],
        longe: map['longe'],
        locationName: map['clint_location'],
        dpid: map['dpid'],
        items: map['items'],
        count: map['count'],
        uid: map['uid'] as String,
        name: map['name'] as String,
        totalprice: map['totalprice']);
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
