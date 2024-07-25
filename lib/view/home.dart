import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monks_food/controller/data_importer.dart';
import 'package:monks_food/model/db_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF2),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFCD5638),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Text("The Majestic Hotel Kuala Lumpur".substring(0, 30) + " ..."),
            titleTextStyle: GoogleFonts.josefinSans(
              textStyle: TextStyle(color: Colors.white),
            )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              decoration: InputDecoration(
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
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/${e.toLowerCase()}.png"), fit: BoxFit.cover)),
                        ),
                        Text(
                          e,
                          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/$e"), fit: BoxFit.cover), borderRadius: BorderRadius.circular(10)),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              FutureBuilder(
                  future: DBManager.instance.getAllMenu(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No stores found'));
                    }

                    final menus = snapshot.data!;
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: menus.length,
                        physics: NeverScrollableScrollPhysics(),
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
                                  image: DecorationImage(image: NetworkImage(menu.image), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ), // Assume image is a URL
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
