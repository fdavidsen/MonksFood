import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monk_food/view/customer/view_order.dart';
import 'package:provider/provider.dart';

class DriverMap extends StatefulWidget {
  final Map<String, dynamic> order;
  const DriverMap({super.key, required this.order});

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapProvider = Provider.of<MapProvider>(context, listen: false);

      List<LatLng> locs = [LatLng(widget.order["destination"]["latitude"], widget.order["destination"]["longitude"])];
      for (var item in widget.order["orders"]) {
        LatLng loc = LatLng(item["latitude"], item["longitude"]);
        locs.add(loc);
      }
      Future.microtask(() => mapProvider.initialize(locs));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFCD5638),
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
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.order["destination"]["latitude"], widget.order["destination"]["longitude"]),
          zoom: 15
        ),
        onMapCreated: (GoogleMapController controller) {
          Provider.of<MapProvider>(context, listen: false).setMapController(controller);
        },
        polylines: Set<Polyline>.of(Provider.of<MapProvider>(context).polylines.values),
        markers: Provider.of<MapProvider>(context).markers.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
