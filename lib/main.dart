import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/view/customer/home.dart';
import 'package:monk_food/view/customer/my_account.dart';
import 'package:monk_food/view/customer/my_card.dart';
import 'package:monk_food/view/onboard/launch_page.dart';
import 'package:monk_food/view/onboard/onboarding.dart';
import 'package:provider/provider.dart';
import 'controller/data_importer.dart';
import 'model/db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.initDB();
  await DataImporter.importStoreAndMenuData();
  String loginRole = await getLoginRole();
  runApp(MyApp(loginRole: loginRole));
}

class MyApp extends StatelessWidget {
  final String loginRole;
  const MyApp({super.key, required this.loginRole});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardController()),
        ChangeNotifierProvider(create: (context) => BottomNavController()),
        ChangeNotifierProvider(create: (context) => EditController()),
        ChangeNotifierProvider(create: (context) => CardController()),
        ChangeNotifierProvider(create: (context) => CustomerAuthProvider()),
      ],
      child: MaterialApp(
        title: 'Monk\'s Food',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: GoogleFonts.josefinSansTextTheme(),
          useMaterial3: true,
        ),
        home: loginRole == 'customer'
            ? const CustomerHomePage()
            : loginRole == 'driver'
                ? const CustomerHomePage()
                : const LaunchPage(),
      ),
    );
  }
}
