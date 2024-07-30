import 'package:flutter/material.dart';
import 'package:monk_food/model/order_modal.dart';

class ViewOrderPage extends StatelessWidget {
  final Order myOrder;
  const ViewOrderPage({super.key, required this.myOrder});

  @override
  Widget build(BuildContext context) {
    print(myOrder);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
        title: Text(
          "Order ${myOrder.id}",
          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: myOrder.cartItems.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = myOrder.cartItems[index];
                  print(item);
                  return Card(
                    color: Color(0xFFFFFEF2),
                    elevation: 4,
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Text(
                        "${item.qty}X",
                        style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: Text(
                        "RM ${(item.qty * item.menu.price).toStringAsFixed(2)}",
                        style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      title: Text(
                        item.menu.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle:
                          Text("Prep time estimation: ${item.menu.time} mins\nRM ${item.menu.price.toStringAsFixed(2)}   Note: ${item.menu.iceHot}"),
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
                    "RM ${myOrder.subtotal.toStringAsFixed(2)}",
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
                    "RM ${myOrder.deliveryFee.toStringAsFixed(2)}",
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
                    "RM ${myOrder.orderFee.toStringAsFixed(2)}",
                    style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: myOrder.couponOffer != "No Offer",
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      myOrder.couponOffer,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "RM -${myOrder.offerFee.toStringAsFixed(2)}",
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
                myOrder.paymentMethod,
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
              ),
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
                myOrder.couponOffer,
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
              ),
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
                "RM ${(myOrder.subtotal + myOrder.deliveryFee + myOrder.orderFee - myOrder.offerFee).toStringAsFixed(2)}",
                style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
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
