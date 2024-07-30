import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/model/cart_item_model.dart';
import 'package:monk_food/model/order_modal.dart';
import 'package:monk_food/view/customer/home.dart';
import 'package:monk_food/view/customer/offer.dart';
import 'package:monk_food/view/customer/payment_method.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double total = Provider.of<CartController>(context, listen: false).calculateTotal();
    List<CartItem> orders = Provider.of<CartController>(context, listen: false).cart;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
        title: Text(
          "Order Summary",
          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: Provider.of<CartController>(context).cart.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = Provider.of<CartController>(context).cart;
                  return Card(
                    color: Color(0xFFFFFEF2),
                    elevation: 4,
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Text(
                        "${item[index].qty}X",
                        style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: Text(
                        "RM ${(item[index].qty * item[index].menu.price).toStringAsFixed(2)}",
                        style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      title: Text(
                        item[index].menu.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                          "Prep time estimation: ${item[index].menu.time} mins\nRM ${item[index].menu.price.toStringAsFixed(2)}   Note: ${item[index].menu.iceHot}"),
                      isThreeLine: true,
                    ),
                  );
                }),
            Divider(),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  title: Text(
                    "Subtotal (Incl. Tax)",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    "RM ${total.toStringAsFixed(2)}",
                    style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  title: Text(
                    "Delivery Fee",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    "RM 2.50",
                    style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  title: Text(
                    "Order Fee",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    "RM 1.00",
                    style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: Provider.of<OfferController>(context).offer != "No Offer",
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      Provider.of<OfferController>(context).offer,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "RM -${Provider.of<OfferController>(context, listen: false).getOffer().toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              title: Text(
                "Payment method",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                Provider.of<PaymentController>(context).method,
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentMethodPage()));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              title: Text(
                "Offer",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                Provider.of<OfferController>(context).offer,
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferPage()));
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              title: Text(
                "Total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                "RM ${(total + 2.5 + 1 - Provider.of<OfferController>(context, listen: false).getOffer()).toStringAsFixed(2)}",
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<OrderController>(context, listen: false).addOrder(Order(
                    id: "${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}${Random().nextInt(10000).toString().padLeft(4, '0')}",
                    cartItems: orders,
                    subtotal: total,
                    deliveryFee: 2.5,
                    orderFee: 1,
                    couponOffer: Provider.of<OfferController>(context, listen: false).offer,
                    offerFee: Provider.of<OfferController>(context, listen: false).getOffer(),
                    paymentMethod: Provider.of<PaymentController>(context, listen: false).method,
                    userId: Provider.of<CustomerAuthProvider>(context, listen: false).user!.id,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your order is confirmed')));
                  Navigator.of(context).pop();
                  Provider.of<CartController>(context, listen: false).clearCart(Provider.of<CustomerAuthProvider>(context, listen: false).user!.id);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCD5638),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentController extends ChangeNotifier {
  String method = "Cash";

  void changeMethod(String m) {
    method = m;
    notifyListeners();
  }
}

class OfferController extends ChangeNotifier {
  String offer = "No Offer";

  void changeOffer(String o) {
    offer = o;
    notifyListeners();
  }

  double getOffer() {
    if (offer == "Free Shipping Coupon") {
      return 2.5;
    } else if (offer == "Raya Offers Coupon") {
      return 5;
    } else {
      return 0;
    }
  }
}
