import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:monk_food/model/db_manager.dart';

class DataImporter {
  static Future<void> importStoreAndMenuData() async {
    ByteData data = await rootBundle.load('assets/menu_data.xlsx');
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    var storeSheet = excel['store'];
    List<Map<String, dynamic>> storeItems = [];
    for (var row in storeSheet.rows.skip(1)) {
      storeItems.add({
        'id': row[0]!.value,
        'name': row[1]!.value,
        'image': row[2]!.value,
        'category': row[3]!.value,
        'latitude': row[4]!.value,
        'longitude': row[5]!.value,
      });
    }
    await DBManager.instance.insertMany(DBManager.instance.tableStore, storeItems);

    var menuSheet = excel['menu'];
    List<Map<String, dynamic>> menuItems = [];
    for (var row in menuSheet.rows.skip(1)) {
      menuItems.add({
        'id': row[0]!.value,
        'store_id': row[1]!.value,
        'name': row[2]!.value,
        'description': row[3]!.value,
        'image': row[4]!.value,
        'ice_hot': row[5]!.value,
        'price': row[6]!.value,
        'tag': row[7]!.value,
        'category': row[8]!.value,
        'rating': row[9]!.value,
        'time': row[10]!.value,
      });
    }
    await DBManager.instance.insertMany(DBManager.instance.tableMenu, menuItems);
  }
}

List<String> categories = ["Meals", "Coffee", "Drink", "Cake"];

List<String> discounts = [
  "discount01.png",
  "discount02.jpg",
];
