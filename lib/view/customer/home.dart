import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/customer_auth_provider.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:monk_food/model/cart_item_model.dart';
import 'package:monk_food/model/query/customer_handler.dart';
import 'package:monk_food/model/customer_model.dart';
import 'package:monk_food/model/order_modal.dart';
import 'package:monk_food/view/customer/drawers.dart';
import 'package:monk_food/view/customer/order.dart';
import 'package:monk_food/view/customer/search.dart';
import 'package:monk_food/view/customer/stores.dart';
import 'package:provider/provider.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Customer user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    final customerAuthProvider = Provider.of<CustomerAuthProvider>(context, listen: false);
    await customerAuthProvider.loadUser();
    user = customerAuthProvider.user!;
    Provider.of<CartController>(context, listen: false)._loadCart(user.id);
    Provider.of<OrderController>(context, listen: false)._loadOrder(user.id);
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
              controller: Provider.of<SearchControllerProvider>(context).getTextController(),
              onChanged: (val) {
                print(val);
                Provider.of<SearchControllerProvider>(context, listen: false).changeText(val);
              },
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
      body: Provider.of<SearchControllerProvider>(context).getTextController().text.isEmpty ? HomeView(context) : const SearchView(),
      drawerEnableOpenDragGesture: false,
      onEndDrawerChanged: (isOpen) {
        if (!isOpen) {
          Provider.of<BottomNavController>(context, listen: false).changeIndex(0);
        }
      },
      endDrawer: Consumer<BottomNavController>(
        builder: (context, bottomNavController, child) {
          if (bottomNavController.selected == 1) {
            return CartDrawer(context);
          } else if (bottomNavController.selected == 2) {
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
        currentIndex: Provider.of<BottomNavController>(context).selected,
        onTap: (index) {
          Provider.of<BottomNavController>(context, listen: false).changeIndex(index);
          if (index == 1 || index == 2) {
            _scaffoldKey.currentState?.openEndDrawer();
          }
        },
      ),
    );
  }
}

Widget HomeView(BuildContext context) {
  return Container(
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
  );
}

class BottomNavController extends ChangeNotifier {
  int selected = 0;

  void changeIndex(int index) {
    selected = index;
    notifyListeners();
  }
}

class CartController extends ChangeNotifier {
  List<CartItem> cart = [];

  Future<void> _loadCart(int userId) async {
    cart = await CustomerHandler().getCartItems(userId);
    notifyListeners();
  }

  void addCartItem(CartItem item) async {
    await CustomerHandler().insertCartItem(item);
    cart.add(item);
    notifyListeners();
  }

  Future<void> removeCartItem(CartItem item) async {
    await CustomerHandler().deleteCartItem(item.id!);
    cart.remove(item);
    notifyListeners();
  }

  void clearCart(int userId) async {
    await CustomerHandler().clearCart(userId);
    cart = [];
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0;
    for (var item in cart) {
      total += (item.menu.price * item.qty);
    }
    return total;
  }
}

class OrderController extends ChangeNotifier {
  List<Order> order = [];

  Future<void> _loadOrder(int userId) async {
    order = await CustomerHandler().getOrderList(userId);
    notifyListeners();
    print(order);
  }

  void addOrder(Order item) async {
    await CustomerHandler().insertOrder(item);
    order.add(item);
    notifyListeners();
  }
}
