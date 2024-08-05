import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:monk_food/controller/driver_auth_provider.dart';
import 'package:monk_food/model/query/db_manager.dart';
import 'package:monk_food/view/customer/checkout.dart';
import 'package:monk_food/view/customer/home.dart';
import 'package:monk_food/view/customer/drawer/my_account.dart';
import 'package:monk_food/view/customer/drawer/my_card.dart';
import 'package:monk_food/view/customer/order.dart';
import 'package:monk_food/view/customer/search.dart';
import 'package:monk_food/view/customer/view_order.dart';
import 'package:monk_food/view/driver/drawer/my_account.dart';
import 'package:monk_food/view/driver/home.dart';
import 'package:monk_food/view/onboard/launch_page.dart';
import 'package:monk_food/view/onboard/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.initDB();
  await DataImporter.importStoreAndMenuData();
  String loginRole = await getLoginRole();
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
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
        ChangeNotifierProvider(create: (context) => DriverBottomNavController()),
        ChangeNotifierProvider(create: (context) => EditController()),
        ChangeNotifierProvider(create: (context) => DriverEditController()),
        ChangeNotifierProvider(create: (context) => CardController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => ChipSelectionController()),
        ChangeNotifierProvider(create: (context) => CounterController()),
        ChangeNotifierProvider(create: (context) => PaymentController()),
        ChangeNotifierProvider(create: (context) => OfferController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => CustomerAuthProvider()),
        ChangeNotifierProvider(create: (context) => DriverAuthProvider()),
        ChangeNotifierProvider(create: (context) => SearchControllerProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider())
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
                ? const DriverHomePage()
                : const LaunchPage(),
      ),
    );
  }
}
