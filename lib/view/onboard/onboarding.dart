import 'package:flutter/material.dart';
import 'package:monk_food/view/onboard/choose_identity.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class Onboarding extends StatelessWidget {
  Onboarding({super.key});
  final controller = PageController(
      viewportFraction: 1,
      keepPage: false,
      initialPage: 0
  );
  List<Widget> pages = [OnBoardingA(),OnBoardingB(),OnBoardingC()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        actions: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>const ChooseIdentity())
              );
              Provider.of<OnboardController>(context,listen: false).swipePos(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCD5638),
              foregroundColor: Colors.white
            ),
            child: const Text("Skip"),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index){
                  Provider.of<OnboardController>(context,listen: false).swipePos(index);
                },
                itemBuilder: (context, index){
                  return pages[index];
                }
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: const Color(0xFFCD5638),
                dotColor: const Color(0xFFCD5638).withOpacity(0.60)
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: (){
                  if(Provider.of<OnboardController>(context, listen: false).pagePos < pages.length-1){
                    controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease
                    );
                  }
                  else{
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>const ChooseIdentity())
                    );
                    Provider.of<OnboardController>(context,listen: false).swipePos(0);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCD5638),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10
                  )
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget OnBoardingA(){
  return Container(
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick\nDelivery",
          style: TextStyle(
            fontSize: 60,
            color: Color(0xFFCD5638)
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                "assets/Ellipse 13.png"
              )
            ),
          ],
        ),
      ],
    ),
  );
}

Widget OnBoardingB(){
  return Container(
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delicious\nFood",
          style: TextStyle(
            fontSize: 60,
            color: Color(0xFFCD5638)
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                "assets/Ellipse 14.png"
              )
            ),
          ],
        ),
      ],
    ),
  );
}

Widget OnBoardingC(){
  return Container(
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Varieties\nRestaurant",
          style: TextStyle(
            fontSize: 60,
            color: Color(0xFFCD5638)
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                "assets/Ellipse 15.png"
              )
            ),
          ],
        ),
      ],
    ),
  );
}

class OnboardController extends ChangeNotifier{
  int pagePos = 0;

  void swipePos(int pos){
    pagePos = pos;
    notifyListeners();
  }
}