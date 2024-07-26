import 'package:flutter/material.dart';
import 'package:monk_food/view/onboard/onboarding.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        color: const Color(0xFFFFFEF2),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/monkeylogo.png"
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
            const Image(
              image: AssetImage(
                "assets/Rectangle 2704.png"
              )
            ),
            const SizedBox(height: 20),
            const Image(
              image: AssetImage(
                "assets/Rectangle 2707.png"
              )
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    "assets/Rectangle 2708.png"
                  )
                ),
                SizedBox(width: 20),
                Image(
                  image: AssetImage(
                    "assets/Rectangle 2709.png"
                  )
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Onboarding())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCD5638),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5
                )
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFFFFEF2),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFCD5638),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
