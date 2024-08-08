import 'package:monk_food/model/cart_item_model.dart';

class Order {
  String id;
  int userId;
  String? cartItemIds;
  List<CartItem> cartItems;
  double subtotal;
  double deliveryFee;
  double orderFee;
  String couponOffer;
  double offerFee;
  String paymentMethod;

  Order({
    this.cartItemIds,
    required this.id,
    required this.userId,
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.orderFee,
    required this.couponOffer,
    required this.offerFee,
    required this.paymentMethod,
  }) {
    cartItemIds ??= cartItems.map((item) => item.id.toString()).join(',');
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    final cartItems = (map['cart_items'] as List).map((cartItemMap) => CartItem.fromMap(cartItemMap)).toList();
    return Order(
      id: map['id'] as String,
      userId: map['user_id'] as int,
      cartItems: cartItems,
      subtotal: map['subtotal'] as double,
      deliveryFee: map['delivery_fee'] as double,
      orderFee: map['order_fee'] as double,
      couponOffer: map['coupon_offer'] as String,
      offerFee: map['offer_fee'] as double,
      paymentMethod: map['payment_method'] as String,
      cartItemIds: map['cart_item_ids'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'cart_item_ids': cartItemIds,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'order_fee': orderFee,
      'coupon_offer': couponOffer,
      'offer_fee': offerFee,
      'payment_method': paymentMethod,
    };
  }

  @override
  String toString() {
    return 'Order(id: $id, cart_item_ids: $cartItemIds, subtotal: $subtotal, deliveryFee: $deliveryFee, orderFee: $orderFee, coupon_offer: $couponOffer, offerFee: $offerFee, paymentMethod: $paymentMethod)';
  }
}
