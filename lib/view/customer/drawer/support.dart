import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: <Widget>[
            const Text(
              "Customers Support",
              style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
            ),
            Expanded(
              child: SizedBox()
            ),
            SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'How can we help you?',
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
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                      Icons.send,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFCD5638),
                      foregroundColor: const Color(0xFFFFFEF2),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
