import 'package:flutter/material.dart';
import 'package:monk_food/view/customer/auth/login_screen.dart';

class ChooseIdentity extends StatelessWidget {
  const ChooseIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFFFFEF2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose Identity",
              style: TextStyle(fontSize: 40, color: Color(0xFFCD5638)),
            ),
            const SizedBox(height: 60),
            const Image(image: AssetImage("assets/hero login.png")),
            const SizedBox(height: 60),
            const Text(
              "Are you a driver ?",
              style: TextStyle(fontSize: 20, color: Color(0xFFCD5638)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCD5638),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                child: const Text(
                  "Yes, I'm a driver",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Are you Hungry ?",
              style: TextStyle(fontSize: 20, color: Color(0xFFCD5638)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCD5638),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                child: const Text(
                  "Yes, I'm starving now",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
