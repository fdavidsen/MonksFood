import 'package:flutter/material.dart';
import 'package:monk_food/view/onboard/choose_identity.dart';

class RegistrationReceivedScreen extends StatelessWidget {
  const RegistrationReceivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Register Received",
                style: TextStyle(color: Color(0xFFCD5638), fontSize: 40),
              ),
              const SizedBox(height: 30),
              Text(
                'Thank you for your registration.',
                style: TextStyle(
                  color: Color(0xFF727171),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'It will take 3 to 7 business days to review your registration.',
                style: TextStyle(
                  color: Color(0xFF727171),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'The review results will be sent to you via email.',
                style: TextStyle(
                  color: Color(0xFF727171),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ChooseIdentity()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCD5638),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                    child: const Text(
                      'Done',
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
}
