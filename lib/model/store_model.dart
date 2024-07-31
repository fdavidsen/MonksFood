class Store {
  int id;
  String name;
  String image;
  String category;
  double latitude;
  double longitude;

  Store({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      category: map['category'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, image: $image, category: $category, latitude: $latitude, longitude: $longitude)';
  }
}
