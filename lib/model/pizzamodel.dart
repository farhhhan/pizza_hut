import 'dart:convert';
// Class that will be the Model for a Task Object
class 
Pizza {

  final String id;
  String name;
  String description;
  String imageUrl;
  String cate;
  String price;
  
  Pizza({
    required this.id,
    required this.name,
   required this.description,
   required this.imageUrl,
   required this.price,
   required this.cate
  });

  @override
  String toString() => 'Pizza(id: $id, name: $name, description: $description)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl':imageUrl,
      'category': cate,
      'price':price
    };
  }

  factory 
  Pizza.fromMap(Map<String, dynamic> map) {
    return 
    Pizza(
      imageUrl: map['imageUrl'],
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      cate: map['category'] as String,
      price: map['price'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory 
  Pizza.fromJson(String source) =>  Pizza.fromMap(json.decode(source) as Map<String, dynamic>);
}