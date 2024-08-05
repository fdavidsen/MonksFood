import 'package:flutter/material.dart';
import 'package:monk_food/model/query/customer_handler.dart';
import 'package:monk_food/view/customer/order.dart';
import 'package:monk_food/view/customer/stores.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stores",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder(
                future: CustomerHandler().getAllStores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No stores found'));
                  }

                  var stores = snapshot.data!;
                  stores = stores.where((store) {
                    return store.name.toLowerCase().contains(Provider.of<SearchControllerProvider>(context).getTextController().text.toLowerCase());
                  }).toList();

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

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: stores.length,
                          itemBuilder: (context, index) {
                            final storeMenus = menus.where((menu) => menu.storeId == stores[index].id).toList();
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StoresPage(
                                          store: stores[index],
                                          menus: storeMenus,
                                        )));
                              },
                              child: Hero(
                                tag: stores[index].id,
                                child: Container(
                                  width: 270,
                                  height: 160,
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage(stores[index].image), fit: BoxFit.cover),
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
                                            stores[index].name,
                                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            stores[index].category,
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
                          },
                        );
                      });
                }),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menus",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
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

                  var menus = snapshot.data!;
                  menus.sort((a, b) => b.rating.compareTo(a.rating));
                  menus = menus.where((menu) {
                    return menu.name.toLowerCase().contains(Provider.of<SearchControllerProvider>(context).getTextController().text.toLowerCase());
                  }).toList();
                  return ListView.builder(
                    itemCount: menus.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final menu = menus[index];
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class SearchControllerProvider extends ChangeNotifier {
  final TextEditingController _textController = TextEditingController();

  TextEditingController getTextController() => _textController;

  void changeText(String val) {
    _textController.text = val;
    notifyListeners();
  }

  void clearText() {
    _textController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
