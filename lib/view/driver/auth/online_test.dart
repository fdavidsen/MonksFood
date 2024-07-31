import 'package:flutter/material.dart';
import 'package:monk_food/model/driver_model.dart';
import 'package:monk_food/view/driver/auth/set_bank_account.dart';

class OnlineTestInfoScreen extends StatelessWidget {
  final Driver driver;
  const OnlineTestInfoScreen({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Online Test",
                style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Beginner's Manual",
              style: TextStyle(color: Color(0xFFCD5638), fontSize: 20, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please carefully read the Monk'sFood Newcomer Handbook.",
              style: TextStyle(color: Color(0xFF727171), fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              "Monk'sFood Course",
              style: TextStyle(color: Color(0xFFCD5638), fontSize: 20, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 10),
            const Text(
              "Learn the four courses for Monk's Food delivery partners.",
              style: TextStyle(color: Color(0xFF727171), fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "The online test will cover the above content.",
              style: TextStyle(
                color: Color(0xFFCD5638),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Monk'sFood Online Test",
              style: TextStyle(color: Color(0xFFCD5638), fontSize: 20, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 10),
            const Text(
              "To pass the Monk'sFood online test, you need to score at least 90.",
              style: TextStyle(color: Color(0xFF727171), fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SetBankAccountScreen(driver: driver)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCD5638),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
