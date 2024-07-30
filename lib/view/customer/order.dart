import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/model/cart_item_model.dart';
import 'package:monk_food/model/menu_model.dart';
import 'package:monk_food/view/customer/home.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  final Menu menu;
  const OrderPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    var choice = Provider.of<ChipSelectionController>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height / 4.5,
                leading: IconButton(
                  onPressed: () {
                    Provider.of<ChipSelectionController>(context, listen: false).changeSelection('');
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(foregroundColor: Color(0xFFFFFEF2), backgroundColor: Color(0xFFCD5638)),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: menu.id,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(menu.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            children: menu.tag.split(",").map((e) {
                              return Chip(
                                label: Text(e),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color(0xFFFFFEF2),
                                labelStyle: TextStyle(color: choice.selectedOption == e ? Colors.white : Colors.black),
                                side: BorderSide(
                                  color: Color(0xFFCD5638),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          Text(
                            menu.name,
                            style: TextStyle(color: Color(0xFF727171), fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            menu.description,
                            style: TextStyle(
                              color: Color(0xFF727171),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                              visible: menu.iceHot != "-",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ice/Hot",
                                        style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 8,
                                    children: menu.iceHot.split(",").map((e) {
                                      return ChoiceChip(
                                        label: Text(e),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        selected: choice.selectedOption == e,
                                        selectedColor: Color(0xFFCD5638),
                                        backgroundColor: Color(0xFFFFFEF2),
                                        labelStyle: TextStyle(color: choice.selectedOption == e ? Colors.white : Colors.black),
                                        checkmarkColor: choice.selectedOption == e ? Colors.white : Colors.black,
                                        onSelected: (selected) {
                                          Provider.of<ChipSelectionController>(context, listen: false).changeSelection(selected ? e : '');
                                        },
                                      );
                                    }).toList(),
                                  )
                                ],
                              )),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputQty(
                                minVal: 1,
                                initVal: Provider.of<CounterController>(context).amount,
                                maxVal: 100,
                                decoration: QtyDecorationProps(
                                    btnColor: Color(0xFFCD5638),
                                    contentPadding: EdgeInsets.all(5),
                                    enabledBorder:
                                        OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Color(0xFFCD5638))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Color(0xFFCD5638)))),
                                onQtyChanged: (val) {
                                  Provider.of<CounterController>(context, listen: false).changeAmount(val.toInt());
                                },
                              ),
                              Text(
                                "RM ${(menu.price * Provider.of<CounterController>(context).amount).toStringAsFixed(2)}",
                                style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ElevatedButton(
                              onPressed: () {
                                if (menu.iceHot != "-" && choice.selectedOption.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please choose your ice/hot')));
                                } else {
                                  Provider.of<CartController>(context, listen: false).addCartItem(CartItem(
                                    menu: menu,
                                    menuId: menu.id,
                                    qty: Provider.of<CounterController>(context, listen: false).amount,
                                    selectedIceHot: Provider.of<ChipSelectionController>(context, listen: false).selectedOption,
                                    userId: Provider.of<CustomerAuthProvider>(context, listen: false).user!.id,
                                  ));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${menu.name} added to cart')));
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFCD5638),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterController extends ChangeNotifier {
  int amount = 1;

  void changeAmount(int val) {
    amount = val;
    notifyListeners();
  }
}

class ChipSelectionController extends ChangeNotifier {
  String selectedOption = '';

  void changeSelection(String option) {
    selectedOption = option;
    notifyListeners();
  }
}
