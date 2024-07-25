import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monks_food/view/onboard/launch_page.dart';
import 'package:monks_food/view/onboard/onboarding.dart';
import 'package:provider/provider.dart';
import 'controller/data_importer.dart';
import 'model/db_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.initDB();
  await DataImporter.importStoreAndMenuData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => OnboardController())],
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
