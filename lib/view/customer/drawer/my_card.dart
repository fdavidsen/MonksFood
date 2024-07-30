import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCardPage extends StatelessWidget {
  const MyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://w7.pngwing.com/pngs/385/197/png-transparent-visa-flat-brand-logo-icon.png"
                              )
                            )
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://thumbs.dreamstime.com/z/mastercard-logo-icon-mastercard-incorporated-american-multinational-financial-services-corporation-headquartered-204759308.jpg"
                              )
                            )
                          ),
                        ),
                      ],
                      isSelected: Provider.of<CardController>(context).selectedCards,
                      selectedBorderColor: Color(0xFFCD5638),
                      onPressed: (index){
                        Provider.of<CardController>(context, listen: false).changeSelectedCards(index);
                      },
                    )
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
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                      return 'Please enter a username';
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
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
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
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      // Example: simple phone number validation
                      return 'Please enter a valid phone number';
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
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'DD/MM/YYYY',
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                disabledBorder: InputBorder.none,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "CVV/CVC",
                                  style: TextStyle(color: Color(0xFFCD5638), fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'CVV/CVC',
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCD5638))),
                                disabledBorder: InputBorder.none,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardController extends ChangeNotifier{
  List<bool> selectedCards = [true, false];

  void changeSelectedCards(int index){
    if(index == 0){
      selectedCards = [true, false];
    }
    else{
      selectedCards = [false, true];
    }
    notifyListeners();
  }
}