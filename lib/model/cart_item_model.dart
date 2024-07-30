import 'package:monk_food/model/menu_model.dart';

class CartItem {
  int? id;
  int userId;
  int menuId;
  Menu menu;
  int qty;
  String selectedIceHot;
  bool isActive;

  CartItem({
    this.id,
    required this.userId,
    required this.menuId,
    required this.menu,
    required this.qty,
    required this.selectedIceHot,
    this.isActive = true, // Set default value to true
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['cart_id'] as int,
      userId: map['user_id'] as int,
      menuId: map['menu_id'] as int,
      qty: map['qty'] as int,
      selectedIceHot: map['selected_ice_hot'] as String,
      isActive: map['is_active'] == 1, // Convert integer to boolean
      menu: Menu(
        id: map['menu_id'] as int,
        storeId: map['store_id'] as int,
        name: map['menu_name'] as String,
        description: map['description'] as String,
        image: map['image'] as String,
        iceHot: map['menu_ice_hot'] as String,
        price: map['price'] as double,
        tag: map['tag'] as String,
        category: map['category'] as String,
        rating: map['rating'] as double,
        time: map['time'] as String,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'menu_id': menuId,
      'qty': qty,
      'selected_ice_hot': selectedIceHot,
      'is_active': isActive ? 1 : 0, // Convert boolean to integer
    };
  }

  @override
  String toString() {
    return 'CartItem(id: $id, userId: $userId, menuId: $menuId, menuName: ${menu.name}, qty: $qty, selected_ice_hot: $selectedIceHot, isActive: $isActive)';
  }
}
