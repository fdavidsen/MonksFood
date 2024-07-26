import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monk_food/controller/auth_utils.dart';
import 'package:monk_food/controller/data_importer.dart';
import 'package:monk_food/model/db_manager.dart';
import 'package:monk_food/view/auth/login_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            title: Text("${"The Majestic Hotel Kuala Lumpur".substring(0, 30)} ..."),
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
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              FutureBuilder(
                  future: DBManager.instance.getAllMenu(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No stores found'));
                    }

                    final menus = snapshot.data!;
                    return ListView.builder(
                      itemCount: menus.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final menu = menus[index];
                        return ListTile(
                          title: Text(menu.name),
                          subtitle: Text("RM ${menu.price}  ${menu.time} mins\n⭐${menu.rating} ${menu.tag}"),
                          isThreeLine: true,
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(menu.image), fit: BoxFit.cover), borderRadius: BorderRadius.circular(10)),
                          ), // Assume image is a URL
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: const <Widget>[
              ListTile(
                title: Text(
                  "your cart is empty",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              )
            ],
          ),
        ),
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: const <Widget>[
              ListTile(
                title: Text(
                  "checkout for some order",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              )
            ],
          ),
        ),
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
              const ListTile(
                leading: Icon(Icons.account_circle_outlined, color: Color(0xFFFFFEF2)),
                title: Text(
                  "My Account",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.mode_comment_outlined, color: Color(0xFFFFFEF2)),
                title: Text(
                  "Support",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.credit_card, color: Color(0xFFFFFEF2)),
                title: Text(
                  "My Card",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.shield_outlined, color: Color(0xFFFFFEF2)),
                title: Text(
                  "Insurance",
                  style: TextStyle(color: Color(0xFFFFFEF2)),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await saveLoginState(false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFFEF2), foregroundColor: const Color(0xFFCD5638)),
          child: const Text("Sign Out"),
        ),
        const SizedBox(height: 15)
      ],
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
