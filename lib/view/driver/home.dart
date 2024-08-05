import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:monk_food/controller/driver_auth_provider.dart';
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
import 'package:monk_food/view/onboard/choose_identity.dart';
import 'package:provider/provider.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Driver user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    final driverAuthProvider = Provider.of<DriverAuthProvider>(context, listen: false);
    await driverAuthProvider.loadUser();
    user = driverAuthProvider.user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFCD5638),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: const [SizedBox()],
        title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: const Text("The Majestic Hotel Kuala Lumpur"),
            titleTextStyle: GoogleFonts.josefinSans(
              textStyle: const TextStyle(color: Colors.white),
            )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Are you hungry?',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View all',
                      style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categories.map((e) {
                    return Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/${e.toLowerCase()}.png"), fit: BoxFit.cover)),
                        ),
                        Text(
                          e,
                          style: const TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Deals Around You",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View all',
                      style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: discounts.map((e) {
                    return Container(
                      width: 270,
                      height: 160,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/$e"), fit: BoxFit.cover), borderRadius: BorderRadius.circular(10)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stores Near You",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'More',
                      style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                    future: CustomerHandler().getAllStores(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No stores found'));
                      }

                      final stores = snapshot.data!;
                      stores.shuffle();
                      return FutureBuilder(
                          future: CustomerHandler().getAllMenu(),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot2.hasError) {
                              return Center(child: Text('Error: ${snapshot2.error}'));
                            } else if (!snapshot2.hasData || snapshot2.data!.isEmpty) {
                              return const Center(child: Text('No stores found'));
                            }
                            final menus = snapshot2.data!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: stores.map((e) {
                                final storeMenus = menus.where((menu) => menu.storeId == e.id).toList();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => StoresPage(
                                              store: e,
                                              menus: storeMenus,
                                            )));
                                  },
                                  child: Hero(
                                    tag: e.id,
                                    child: Container(
                                      width: 270,
                                      height: 160,
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(e.image), fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.7),
                                              ],
                                              stops: const [0.0, 0.7],
                                            ),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.name,
                                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                e.category,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          });
                    }),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommended",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'More',
                      style: TextStyle(fontWeight: FontWeight.bold, decorationColor: Color(0xFFCD5638), color: Color(0xFFCD5638), fontSize: 16),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: CustomerHandler().getAllMenu(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No stores found'));
                    }

                    final menus = snapshot.data!;
                    menus.shuffle();
                    final limitedMenus = menus.take(5).toList();
                    limitedMenus.sort((a, b) => b.rating.compareTo(a.rating));
                    return ListView.builder(
                      itemCount: limitedMenus.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final menu = limitedMenus[index];
                        return Card(
                          color: const Color(0xFFFFFEF2),
                          elevation: 4,
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(menu.name),
                            subtitle: Text("RM ${menu.price}  ${menu.time} mins\n⭐${menu.rating} ${menu.tag}"),
                            isThreeLine: true,
                            leading: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          menu.image,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage(menu: menu)));
                            }, // Assume image is a URL
                          ),
                        );
                      },
                    );
                  }),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      onEndDrawerChanged: (isOpen) {
        if (!isOpen) {
          Provider.of<DriverBottomNavController>(context, listen: false).changeIndex(0);
        }
      },
      endDrawer: Consumer<DriverBottomNavController>(
        builder: (context, DriverbottomNavController, child) {
          if (DriverbottomNavController.selected == 1) {
            return CartDrawer(context);
          } else if (DriverbottomNavController.selected == 2) {
            return OrderDrawer(context);
          } else {
            return const SizedBox();
          }
        },
      ),
      drawer: SideDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFCD5638),
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFCD5638),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFCD5638),
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFCD5638),
            icon: Icon(Icons.article),
            label: 'My Order',
          ),
        ],
        currentIndex: Provider.of<DriverBottomNavController>(context).selected,
        onTap: (index) {
          Provider.of<DriverBottomNavController>(context, listen: false).changeIndex(index);
          if (index == 1 || index == 2) {
            _scaffoldKey.currentState?.openEndDrawer();
          }
        },
      ),
    );
  }
}

Widget CartDrawer(BuildContext context) {
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
              'My Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Provider.of<CartController>(context).cart.isEmpty ? 1 : Provider.of<CartController>(context).cart.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, index) {
              if (Provider.of<CartController>(context).cart.isEmpty) {
                return const ListTile(
                  title: Text(
                    "your cart is empty",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFFFFEF2)),
                  ),
                );
              } else {
                var item = Provider.of<CartController>(context).cart;
                return Card(
                  color: const Color(0xFFFFFEF2),
                  elevation: 4,
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    contentPadding: const EdgeInsets.only(left: 10),
                    title: Text(item[index].menu.name),
                    subtitle: Text("RM ${item[index].menu.price}  ${item[index].menu.time} mins\nAmount: ${item[index].qty}"),
                    isThreeLine: true,
                    leading: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  item[index].menu.image,
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel_rounded),
                      color: const Color(0xFFCD5638),
                      onPressed: () {
                        Provider.of<CartController>(context, listen: false).removeCartItem(item[index]);
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        Visibility(
          visible: Provider.of<CartController>(context).cart.isNotEmpty,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CheckoutPage()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFFEF2), foregroundColor: const Color(0xFFCD5638)),
            child: const Text("Checkout"),
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(foregroundColor: const Color(0xFFFFFEF2)),
          child: const Text("Explore More"),
        ),
        const SizedBox(height: 15)
      ],
    ),
  );
}

Widget OrderDrawer(BuildContext context) {
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
              'My Order',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Provider.of<OrderController>(context).order.isEmpty ? 1 : Provider.of<OrderController>(context).order.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, index) {
              if (Provider.of<OrderController>(context).order.isEmpty) {
                return const ListTile(
                  title: Text(
                    "checkout for some order",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFFFFEF2)),
                  ),
                );
              } else {
                var item = Provider.of<OrderController>(context).order;
                return Card(
                  color: const Color(0xFFFFFEF2),
                  elevation: 4,
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    contentPadding: const EdgeInsets.only(left: 10),
                    title: const Text("Order Number:"),
                    subtitle: Text("${item[index].id}\nSubtotal: RM ${item[index].subtotal.toStringAsFixed(2)}"),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_circle_right),
                      color: const Color(0xFFCD5638),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewOrderPage(myOrder: item[index])));
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFFEF2), foregroundColor: const Color(0xFFCD5638)),
          child: const Text("Explore More"),
        ),
        const SizedBox(height: 15)
      ],
    ),
  );
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

class DriverBottomNavController extends ChangeNotifier {
  int selected = 0;

  void changeIndex(int index) {
    selected = index;
    notifyListeners();
  }
}
