import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/view/onboard/launch_page.dart';
import 'package:monk_food/view/onboard/onboarding.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>OnboardController())
      ],
      child: MaterialApp(
        title: 'Monk\'s Food',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.josefinSansTextTheme(),
          useMaterial3: true,
        ),
        home: const LaunchPage(),
      ),
    );
  }
}
