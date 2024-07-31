import 'package:monk_food/model/store_model.dart';

class Menu {
  int id;
  int storeId;
  Store? store;
  String name;
  String description;
  String image;
  String iceHot;
  double price;
  String tag;
  String category;
  double rating;
  String time;

  Menu({
    this.store,
    required this.id,
    required this.storeId,
    required this.name,
    required this.description,
    required this.image,
    required this.iceHot,
    required this.price,
    required this.tag,
    required this.category,
    required this.rating,
    required this.time,
  });

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      storeId: map['store_id'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      iceHot: map['ice_hot'],
      price: map['price'],
      tag: map['tag'],
      category: map['category'],
      rating: map['rating'],
      time: map['time'],
      store: map['store'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'store_id': storeId,
      'name': name,
      'description': description,
      'image': image,
      'ice_hot': iceHot,
      'price': price,
      'tag': tag,
      'category': category,
      'rating': rating,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'Menu(id: $id, storeId: $storeId, storeName: ${store!.name}, name: $name, description: $description, image: $image, iceHot: $iceHot, price: $price, tag: $tag, category: $category, rating: $rating, time: $time)';
  }
}
