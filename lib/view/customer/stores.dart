import 'package:flutter/material.dart';
import 'package:monk_food/model/menu_model.dart';
import 'package:monk_food/model/store_model.dart';
import 'package:monk_food/view/customer/order.dart';

class StoresPage extends StatelessWidget {
  final Store store;
  final List<Menu> menus;
  const StoresPage({super.key, required this.store, required this.menus});

  @override
  Widget build(BuildContext context) {
    List<Menu> popularItems = menus;
    popularItems.sort((a, b) => b.rating.compareTo(a.rating));

    List<String> categories = menus.map((menu) => menu.category).toSet().toList();

    Map<String, List<Menu>> categorizedMenus = {};

    for (var menu in menus) {
      if (!categorizedMenus.containsKey(menu.category)) {
        categorizedMenus[menu.category] = [];
      }
      categorizedMenus[menu.category]!.add(menu);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 4.5,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              style: IconButton.styleFrom(foregroundColor: Color(0xFFFFFEF2), backgroundColor: Color(0xFFCD5638)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: store.id,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(store.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(color: Color(0xFF727171), fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Popular Items",
                    style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: popularItems.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage(menu: e)));
                          },
                          child: Card(
                            color: Color(0xFFFFFEF2),
                            elevation: 4,
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                              width: 100,
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(e.image), fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(e.name),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "RM ${e.price}",
                                          style: TextStyle(color: Color(0xFFCD5638)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("⭐ ${e.rating}"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categories.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e,
                            style: TextStyle(color: Color(0xFF727171), fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: categorizedMenus[e]!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final menu = categorizedMenus[e]![index];
                              return Card(
                                color: Color(0xFFFFFEF2),
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
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20)
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
