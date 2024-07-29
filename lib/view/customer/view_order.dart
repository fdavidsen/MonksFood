import 'package:flutter/material.dart';

class ViewOrderPage extends StatelessWidget {
  final Map<String, dynamic> myOrder;
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
          "Order ${myOrder["id"]}",
          style: TextStyle(
            color: Color(0xFFCD5638),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: myOrder["menu"].length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                var item = myOrder["menu"][index];
                print(item);
                return Card(
                  color: Color(0xFFFFFEF2),
                  elevation: 4,
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading: Text(
                      "${item["qty"]}X",
                      style: TextStyle(
                          color: Color(0xFFCD5638),
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    trailing: Text(
                      "RM ${(item["qty"] * item["menu"].price).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Color(0xFFCD5638),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    title: Text(
                      item["menu"].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Prep time estimation: ${item["menu"].time} mins\nRM ${item["menu"].price.toStringAsFixed(2)}   Note: ${item["menu"].iceHot}"
                    ),
                    isThreeLine: true,
                  ),
                );
              }
            ),
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
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  trailing: Text(
                    "RM ${myOrder["subtotal"].toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Color(0xFFCD5638),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  title: Text(
                    "Delivery Fee",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  trailing: Text(
                    "RM ${myOrder["delivery_fee"].toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Color(0xFFCD5638),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  title: Text(
                    "Order Fee",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  trailing: Text(
                    "RM ${myOrder["order_fee"].toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Color(0xFFCD5638),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
                Visibility(
                  visible: myOrder["offer"] != "No Offer",
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      myOrder["offer"],
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    trailing: Text(
                      "RM -${myOrder["offer_fee"].toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
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
                myOrder["method"],
                style: TextStyle(
                  color: Color(0xFFCD5638),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
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
                myOrder["offer"],
                style: TextStyle(
                    color: Color(0xFFCD5638),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              title: Text(
                "Total",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Text(
                "RM ${(myOrder["subtotal"]+myOrder["delivery_fee"]+myOrder["order_fee"]-myOrder["offer_fee"]).toStringAsFixed(2)}",
                style: TextStyle(
                    color: Color(0xFFCD5638),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
