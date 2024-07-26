import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/view/home.dart';
import 'package:monk_food/view/onboard/launch_page.dart';
import 'package:monk_food/view/onboard/onboarding.dart';
import 'package:provider/provider.dart';
import 'controller/auth_utils.dart';
import 'controller/data_importer.dart';
import 'model/db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.initDB();
  await DataImporter.importStoreAndMenuData();
  bool isLoggedIn = await getLoginState();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardController()),
        ChangeNotifierProvider(create: (context) => BottomNavController()),
      ],
      child: MaterialApp(
        title: 'Monk\'s Food',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.josefinSansTextTheme(),
          useMaterial3: true,
        ),
        home: isLoggedIn ? HomePage() : const LaunchPage(),
      ),
    );
  }
}
