import 'package:monk_food/model/cart_item_model.dart';
import 'package:monk_food/model/db_manager.dart';
import 'package:monk_food/model/customer_model.dart';
import 'package:monk_food/model/menu_model.dart';
import 'package:monk_food/model/order_modal.dart';
import 'package:monk_food/model/store_model.dart';

class CustomerHandler {
  final String tableCustomers = DBManager.instance.tableCustomers;
  final String tableStore = DBManager.instance.tableStore;
  final String tableMenu = DBManager.instance.tableMenu;
  final String tableCart = DBManager.instance.tableCart;
  final String tableOrders = DBManager.instance.tableOrders;

  Future<List<Store>> getAllStores() async {
    final db = await DBManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableStore);
    return List.generate(maps.length, (i) {
      return Store.fromMap(maps[i]);
    });
  }

  Future<List<Menu>> getAllMenu() async {
    final db = await DBManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableMenu);
    return List.generate(maps.length, (i) {
      return Menu.fromMap(maps[i]);
    });
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await DBManager.instance.database;
    await db.insert(tableCart, item.toMap());
  }

  Future<List<CartItem>> getCartItems(int userId) async {
    final db = await DBManager.instance.database;
    final result = await db.rawQuery('''
      SELECT 
        cart.id as cart_id, 
        cart.user_id as user_id, 
        cart.qty as qty, 
        cart.selected_ice_hot as selected_ice_hot, 
        menu.id as menu_id, 
        menu.store_id as store_id, 
        menu.name as menu_name, 
        menu.description as description, 
        menu.image as image, 
        menu.ice_hot as menu_ice_hot, 
        menu.price as price, 
        menu.tag as tag, 
        menu.category as category, 
        menu.rating as rating, 
        menu.time as time 
      FROM cart 
      JOIN menu ON cart.menu_id = menu.id 
      WHERE cart.user_id = ? AND cart.is_active = 1
    ''', [userId]);

    return List.generate(result.length, (i) {
      return CartItem.fromMap(result[i]);
    });
  }

  Future<void> deleteCartItem(int id) async {
    final db = await DBManager.instance.database;
    await db.update(tableCart, {'is_active': 0}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart(int userId) async {
    final db = await DBManager.instance.database;
    await db.update(tableCart, {'is_active': 0}, where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<void> insertOrder(Order order) async {
    final db = await DBManager.instance.database;
    await db.insert(tableOrders, order.toMap());
  }

  Future<List<CartItem>> getCartItemsByIds(String ids) async {
    final db = await DBManager.instance.database;
    final result = await db.rawQuery('''
      SELECT 
        cart.id as cart_id, 
        cart.user_id as user_id, 
        cart.qty as qty, 
        cart.selected_ice_hot as selected_ice_hot, 
        menu.id as menu_id, 
        menu.store_id as store_id, 
        menu.name as menu_name, 
        menu.description as description, 
        menu.image as image, 
        menu.ice_hot as menu_ice_hot, 
        menu.price as price, 
        menu.tag as tag, 
        menu.category as category, 
        menu.rating as rating, 
        menu.time as time 
      FROM cart 
      JOIN menu ON cart.menu_id = menu.id 
      WHERE cart.id IN ($ids) 
    ''');

    return List.generate(result.length, (i) {
      return CartItem.fromMap(result[i]);
    });
  }

  Future<List<Order>> getOrderList(int userId) async {
    final db = await DBManager.instance.database;
    final orderMaps = await db.query(tableOrders, where: 'user_id = ?', whereArgs: [userId]);

    List<Order> orders = [];
    for (var orderMap in orderMaps) {
      final cartItems = await getCartItemsByIds(orderMap['cart_item_ids'] as String);
      orders.add(Order(
        id: orderMap['id'] as String,
        userId: orderMap['user_id'] as int,
        cartItems: cartItems,
        subtotal: orderMap['subtotal'] as double,
        deliveryFee: orderMap['delivery_fee'] as double,
        orderFee: orderMap['order_fee'] as double,
        couponOffer: orderMap['coupon_offer'] as String,
        offerFee: orderMap['offer_fee'] as double,
        paymentMethod: orderMap['payment_method'] as String,
      ));
    }
    return orders;
  }

  Future<int> updateMyAccount(Customer customer) async {
    final db = await DBManager.instance.database;
    return await db.update(
      tableCustomers,
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> register(Map<String, dynamic> user) async {
    return await DBManager.instance.register(tableCustomers, user);
  }

  Future<bool> isUsernameUnique(String username) async {
    return DBManager.instance.isUsernameUnique(tableCustomers, username);
  }

  Future<bool> isEmailExisted(String email) async {
    return DBManager.instance.isEmailExisted(tableCustomers, email);
  }

  Future<Customer?> login(String username, String password) async {
    final result = await DBManager.instance.login(tableCustomers, username, password);
    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Customer?> getCustomerById(int id) async {
    final result = await DBManager.instance.getUserById(tableCustomers, id);
    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<Customer?> getCustomerByEmail(String email) async {
    final result = await DBManager.instance.getUserByEmail(tableCustomers, email);
    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updateForgetPassword(String email, String newPassword) async {
    return await DBManager.instance.updateForgetPassword(tableCustomers, email, newPassword);
  }
}
