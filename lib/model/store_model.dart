class Store {
  int id;
  String name;
  String image;
  String category;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
  });

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
    };
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, image: $image, category: $category)';
  }
}