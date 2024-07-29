import 'package:flutter/material.dart';
import 'package:monk_food/view/customer/checkout.dart';
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
        title: Text(
          "Payment Method",
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
              tileColor: Provider.of<PaymentController>(context).method == "Cash" ? Color(0xFFCD5638) : Color(0xFFFFFEF2),
              title: Text(
                "Cash",
                style: TextStyle(
                  fontSize: 16,
                  color: Provider.of<PaymentController>(context).method == "Cash" ? Color(0xFFFFFEF2) : Colors.black
                ),
              ),
              leading: Icon(
                Icons.monetization_on,
                color: Provider.of<PaymentController>(context).method == "Cash" ? Colors.white : Color(0xFFCD5638),
              ),
              onTap: (){
                Provider.of<PaymentController>(context, listen: false).changeMethod("Cash");
              },
            ),
            ListTile(
              tileColor: Provider.of<PaymentController>(context).method == "Card" ? Color(0xFFCD5638) : Color(0xFFFFFEF2),
              title: Text(
                "Card",
                style: TextStyle(
                    fontSize: 16,
                    color: Provider.of<PaymentController>(context).method == "Card" ? Color(0xFFFFFEF2) : Colors.black
                ),
              ),
              leading: Icon(
                Icons.credit_card,
                color: Provider.of<PaymentController>(context).method == "Card" ? Colors.white : Color(0xFFCD5638),
              ),
              onTap: (){
                Provider.of<PaymentController>(context, listen: false).changeMethod("Card");
              },
            ),
          ],
        ),
      ),
    );
  }
}
