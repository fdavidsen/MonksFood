import 'package:flutter/material.dart';
import 'package:monks_food/database/db_manager.dart';
import 'package:monks_food/models/menu_model.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<Menu>> _menus;

  @override
  void initState() {
    super.initState();
    _menus = DBManager.instance.getAllMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: FutureBuilder<List<Menu>>(
        future: _menus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No menu items found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final menu = snapshot.data![index];
                return ListTile(
                  title: Text(menu.name),
                  subtitle: Text('${menu.category} - ${menu.price}'),
                  // leading: Image.network(menu.image),
                );
              },
            );
          }
        },
      ),
    );
  }
}
