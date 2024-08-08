import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:monk_food/controller/driver_auth_provider.dart';
import 'package:monk_food/model/order_modal.dart';
import 'package:monk_food/model/query/customer_handler.dart';
import 'package:monk_food/model/driver_model.dart';
import 'package:monk_food/view/customer/checkout.dart';
import 'package:monk_food/view/customer/home.dart';
import 'package:monk_food/view/driver/drawer/my_account.dart';
import 'package:monk_food/view/driver/drawer/bank_account.dart';
import 'package:monk_food/view/driver/drawer/support.dart';
import 'package:monk_food/view/customer/order.dart';
import 'package:monk_food/view/customer/stores.dart';
import 'package:monk_food/view/customer/view_order.dart';
import 'package:monk_food/view/driver/order_map.dart';
import 'package:monk_food/view/onboard/choose_identity.dart';
import 'package:provider/provider.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Driver> userFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userFuture = _loadData();
  }

  Future<Driver> _loadData() async {
    final driverAuthProvider = Provider.of<DriverAuthProvider>(context, listen: false);
    await driverAuthProvider.loadUser();
    return driverAuthProvider.user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFEFEFE5),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFCD5638),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {

            },
          ),
        ],
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          title: const Text("The Majestic Hotel Kuala Lumpur"),
          titleTextStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<Driver>(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final user = snapshot.data!;
                  return Column(
                    children: [
                      ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        tileColor: const Color(0xFFFFFEF2),
                        leading: const CircleAvatar(),
                        title: Text(
                          user.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: const Text("HM6 7345"),
                        trailing: const Text(
                          "Online",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC0BFB9),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Logged from April 19, 7:31 PM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFCD5638),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Task",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text("All"),
                      selected: Provider.of<DriverChipController>(context).choice == "All",
                      selectedColor: const Color(0xFFCD5638),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Provider.of<DriverChipController>(context).choice == "All" ? Colors.white : Colors.black,
                      ),
                      onSelected: (val) {
                        Provider.of<DriverChipController>(context, listen: false).changeChoice("All");
                      },
                    ),
                    const SizedBox(width: 15),
                    ChoiceChip(
                      label: const Text("Confirmed"),
                      selected: Provider.of<DriverChipController>(context).choice == "Confirmed",
                      selectedColor: const Color(0xFFCD5638),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Provider.of<DriverChipController>(context).choice == "Confirmed" ? Colors.white : Colors.black,
                      ),
                      onSelected: (val) {
                        Provider.of<DriverChipController>(context, listen: false).changeChoice("Confirmed");
                      },
                    ),
                    const SizedBox(width: 15),
                    ChoiceChip(
                      label: const Text("Assigned"),
                      selectedColor: const Color(0xFFCD5638),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.white,
                      selected: Provider.of<DriverChipController>(context).choice == "Assigned",
                      labelStyle: TextStyle(
                        color: Provider.of<DriverChipController>(context).choice == "Assigned" ? Colors.white : Colors.black,
                      ),
                      onSelected: (val) {
                        Provider.of<DriverChipController>(context, listen: false).changeChoice("Assigned");
                      },
                    ),
                    const SizedBox(width: 15),
                    ChoiceChip(
                      label: const Text("On Delivery"),
                      selectedColor: const Color(0xFFCD5638),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.white,
                      selected: Provider.of<DriverChipController>(context).choice == "On Delivery",
                      labelStyle: TextStyle(
                        color: Provider.of<DriverChipController>(context).choice == "On Delivery" ? Colors.white : Colors.black,
                      ),
                      onSelected: (val) {
                        Provider.of<DriverChipController>(context, listen: false).changeChoice("On Delivery");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: sampleOrders.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = sampleOrders;
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DriverMap(order: item[index]))
                      );
                    },
                    child: Card(
                      elevation: 4,
                      color: Color(0xFFFFFFEF),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Order #${item[index]["id"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              subtitle: Text(
                                "Today, 8:30 AM"
                              ),
                              trailing: Text(
                                item[index]["status"],
                                style: TextStyle(
                                  color: item[index]["status"] == "Completed" ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: item[index]["orders"].length,
                              itemBuilder: (context, index2){
                                var loc = item[index]["orders"];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.business,
                                        color: Colors.orange,
                                      ),
                                      title: Text(
                                        loc[index2]["location"]
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 27),
                                      height: 15,
                                      width: 2,
                                      color: Colors.black,
                                    )
                                  ],
                                );
                              }
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              title: Text(
                                item[index]["destination"]["location"]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      drawer: SideDrawer(context),
      drawerEnableOpenDragGesture: false,
    );
  }
}

Widget SideDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color(0xFFCD5638),
    child: Column(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFFCD5638),
          ),
          child: Center(
            child: Text(
              'Monk\'s Food',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFFFFFEF2)),
                title: const Text(
                  "Homepage",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined, color: Color(0xFFFFFEF2)),
                title: const Text(
                  "My Account",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyAccountPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.mode_comment_outlined, color: Color(0xFFFFFEF2)),
                title: const Text(
                  "Support",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SupportPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Color(0xFFFFFEF2)),
                title: const Text(
                  "Bank Account",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BankAccountPage()));
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await saveLoginRole('none');
            Provider.of<DriverAuthProvider>(context, listen: false).unsetUser();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChooseIdentity()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFFEF2), foregroundColor: const Color(0xFFCD5638)),
          child: const Text("Sign Out"),
        ),
        const SizedBox(height: 15)
      ],
    ),
  );
}

class DriverChipController extends ChangeNotifier{
  String choice = "All";

  void changeChoice(String c){
    choice = c;
    notifyListeners();
  }
}

List<Map<String, dynamic>> sampleOrders = [
  {
    "id": "202408075201",
    "status": "On Delivery",
    "time": "Today, 12:00 PM",
    "orders": [
      {
        "location": "Starbucks",
        "latitude": 3.13528,
        "longitude":  101.6871
      },
      {
        "location": "Burger King",
        "latitude": 3.13601,
        "longitude":  101.689
      },
    ],
    "destination": {
      "location": "The Majestic Hotel Kuala Lumpur",
      "latitude": 3.13950166142615,
      "longitude":  101.69226325815785
    }
  },
  {
    "id": "202408075200",
    "status": "Completed",
    "time": "Today, 8:30 AM",
    "orders": [
      {
        "location": "Kentucky Fried Chicken",
        "latitude": 3.13412,
        "longitude":  101.68653
      },
      {
        "location": "OldTown White Coffee",
        "latitude": 3.139003,
        "longitude":  101.686855
      },
    ],
    "destination": {
      "location": "The Majestic Hotel Kuala Lumpur",
      "latitude": 3.13950166142615,
      "longitude":  101.69226325815785
    }
  }
];
