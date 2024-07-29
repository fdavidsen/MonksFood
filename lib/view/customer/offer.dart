import 'package:flutter/material.dart';
import 'package:monk_food/view/customer/checkout.dart';
import 'package:provider/provider.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
        title: Text(
          "Offers",
          style: TextStyle(
              color: Color(0xFFCD5638),
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              tileColor: Provider.of<OfferController>(context).offer == "Free Shipping Coupon" ? Color(0xFFCD5638) : Color(0xFFFFFEF2),
              title: Text(
                "Free Shipping Coupon",
                style: TextStyle(
                    fontSize: 16,
                    color: Provider.of<OfferController>(context).offer == "Free Shipping Coupon" ? Color(0xFFFFFEF2) : Colors.black
                ),
              ),
              leading: Icon(
                Icons.discount,
                color: Provider.of<OfferController>(context).offer == "Free Shipping Coupon" ? Colors.white : Color(0xFFCD5638),
              ),
              onTap: (){
                Provider.of<OfferController>(context, listen: false).changeOffer("Free Shipping Coupon");
              },
            ),
            ListTile(
              tileColor: Provider.of<OfferController>(context).offer == "Raya Offers Coupon" ? Color(0xFFCD5638) : Color(0xFFFFFEF2),
              title: Text(
                "Raya Offers Coupon",
                style: TextStyle(
                    fontSize: 16,
                    color: Provider.of<OfferController>(context).offer == "Raya Offers Coupon" ? Color(0xFFFFFEF2) : Colors.black
                ),
              ),
              leading: Icon(
                Icons.discount,
                color: Provider.of<OfferController>(context).offer == "Raya Offers Coupon" ? Colors.white : Color(0xFFCD5638),
              ),
              onTap: (){
                Provider.of<OfferController>(context, listen: false).changeOffer("Raya Offers Coupon");
              },
            ),
            ListTile(
              tileColor: Provider.of<OfferController>(context).offer == "No Offer" ? Color(0xFFCD5638) : Color(0xFFFFFEF2),
              title: Text(
                "Don't Use Offer",
                style: TextStyle(
                    fontSize: 16,
                    color: Provider.of<OfferController>(context).offer == "No Offer" ? Color(0xFFFFFEF2) : Colors.black
                ),
              ),
              leading: Icon(
                Icons.discount,
                color: Provider.of<OfferController>(context).offer == "No Offer" ? Colors.white : Color(0xFFCD5638),
              ),
              onTap: (){
                Provider.of<OfferController>(context, listen: false).changeOffer("No Offer");
              },
            ),
          ],
        ),
      ),
    );
  }
}
