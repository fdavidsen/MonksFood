import 'package:flutter/material.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/model/customer_handler.dart';
import 'package:monk_food/model/customer_model.dart';
import 'package:provider/provider.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  _MyCardPageState createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();

  late Customer customer;
  late Future<void> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUserData();
  }

  Future<void> _loadUserData() async {
    final customerAuthProvider = Provider.of<CustomerAuthProvider>(context, listen: false);
    if (customerAuthProvider.user != null) {
      customer = customerAuthProvider.user!;
      _firstNameController.text = customer.cardFirstName ?? '';
      _lastNameController.text = customer.cardLastName ?? '';
      _cardNumberController.text = customer.cardNumber ?? '';
      _expirationDateController.text = customer.expirationDate ?? '';
      _cvvController.text = customer.cvv ?? '';
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      final updatedCustomer = Customer(
        id: customer.id,
        username: customer.username,
        email: customer.email,
        phone: customer.phone,
        password: customer.password,
        cardFirstName: _firstNameController.text,
        cardLastName: _lastNameController.text,
        cardNumber: _cardNumberController.text,
        expirationDate: _expirationDateController.text,
        cvv: _cvvController.text,
      );

      customer = updatedCustomer;
      await CustomerHandler().updateCustomerData(updatedCustomer);
      Provider.of<CustomerAuthProvider>(context, listen: false).setUser(updatedCustomer);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update successful')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: FutureBuilder<void>(
        future: _loadUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "My Card",
                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ToggleButtons(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://w7.pngwing.com/pngs/385/197/png-transparent-visa-flat-brand-logo-icon.png"),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://thumbs.dreamstime.com/z/mastercard-logo-icon-mastercard-incorporated-american-multinational-financial-services-corporation-headquartered-204759308.jpg"),
                                  ),
                                ),
                              ),
                            ],
                            isSelected: Provider.of<CardController>(context).selectedCards,
                            selectedBorderColor: const Color(0xFFCD5638),
                            onPressed: (index) {
                              Provider.of<CardController>(context, listen: false).changeSelectedCards(index);
                            },
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "First Name",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Last Name",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Card Number",
                            style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _cardNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Card Number',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                          disabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your card number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Expiration Date",
                                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    controller: _expirationDateController,
                                    decoration: const InputDecoration(
                                      labelText: 'MM/YY',
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the expiration date';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CVV",
                                        style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    controller: _cvvController,
                                    decoration: const InputDecoration(
                                      labelText: 'CVV',
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the CVV';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: _updateUserData,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFCD5638),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                            child: const Text(
                              'Save & Back',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CardController extends ChangeNotifier {
  List<bool> selectedCards = [false, false];

  void changeSelectedCards(int index) {
    for (int i = 0; i < selectedCards.length; i++) {
      selectedCards[i] = i == index;
    }
    notifyListeners();
  }
}
