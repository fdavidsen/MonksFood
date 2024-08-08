import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monk_food/model/order_modal.dart';
import 'package:provider/provider.dart';

class ViewOrderPage extends StatefulWidget {
  final Order myOrder;
  ViewOrderPage({super.key, required this.myOrder});

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  LatLng myLocation = const LatLng(3.139263417193467, 101.6922524120604);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapProvider = Provider.of<MapProvider>(context, listen: false);

      List<LatLng> locs = [myLocation];
      for (var cartItem in widget.myOrder.cartItems) {
        var store = cartItem.menu.store;
        if (store != null) {
          LatLng loc = LatLng(store.latitude, store.longitude);
          locs.add(loc);
        }
      }
      Future.microtask(() => mapProvider.initialize(locs));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: myLocation,
      zoom: 14,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
        title: Text(
          "Order ${widget.myOrder.id}",
          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          Provider.of<MapProvider>(context, listen: false).setMapController(controller);
        },
        polylines: Set<Polyline>.of(Provider.of<MapProvider>(context).polylines.values),
        markers: Provider.of<MapProvider>(context).markers.toSet(),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height / 3,
        decoration:
            BoxDecoration(color: Color(0xFFFFFEF2), borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.myOrder.cartItems.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = widget.myOrder.cartItems[index];
                    print(item);
                    return Card(
                      color: Color(0xFFFFFEF2),
                      elevation: 4,
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        leading: Text(
                          "${item.qty}X",
                          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: Text(
                          "RM ${(item.qty * item.menu.price).toStringAsFixed(2)}",
                          style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        title: Text(
                          item.menu.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                            "Prep time estimation: ${item.menu.time} mins\nRM ${item.menu.price.toStringAsFixed(2)}   Note: ${item.menu.iceHot}"),
                        isThreeLine: true,
                      ),
                    );
                  }),
              Divider(),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      "Subtotal (Incl. Tax)",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "RM ${widget.myOrder.subtotal.toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      "Delivery Fee",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "RM ${widget.myOrder.deliveryFee.toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    dense: true,
                    title: Text(
                      "Order Fee",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      "RM ${widget.myOrder.orderFee.toStringAsFixed(2)}",
                      style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Visibility(
                    visible: widget.myOrder.couponOffer != "No Offer",
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      dense: true,
                      title: Text(
                        widget.myOrder.couponOffer,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        "RM -${widget.myOrder.offerFee.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                dense: true,
                title: Text(
                  "Payment method",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  widget.myOrder.paymentMethod,
                  style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                dense: true,
                title: Text(
                  "Offer",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  widget.myOrder.couponOffer,
                  style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                dense: true,
                title: Text(
                  "Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "RM ${(widget.myOrder.subtotal + widget.myOrder.deliveryFee + widget.myOrder.orderFee - widget.myOrder.offerFee).toStringAsFixed(2)}",
                  style: TextStyle(color: Color(0xFFCD5638), fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapProvider with ChangeNotifier {
  List<Marker> markers = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  late GoogleMapController googleMapController;

  final String apiKey = 'AIzaSyCdIQnif6IpMKA-oUdYAox6RERXi76A6fs';

  void initialize(List<LatLng> locs) {
    markers = [];
    for (var loc in locs) {
      addMarker(loc);
    }
  }

  void setMapController(GoogleMapController controller) {
    googleMapController = controller;
    notifyListeners();
  }

  void addMarker(LatLng latLng) {
    markers.add(
      Marker(
        consumeTapEvents: true,
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onTap: () {
          markers.removeWhere((element) => element.markerId == MarkerId(latLng.toString()));
          if (markers.length > 1) {
            getDirections();
          } else {
            polylines.clear();
          }
          notifyListeners();
        },
      ),
    );
    if (markers.length > 1) {
      getDirections();
    }
    print(markers.length);
    notifyListeners();
  }

  Future<void> getDirections() async {
    List<LatLng> polylineCoordinates = [];
    List<PolylineWayPoint> polylineWayPoints = [];
    for (var marker in markers) {
      polylineWayPoints.add(PolylineWayPoint(
        location: "${marker.position.latitude},${marker.position.longitude}",
        stopOver: true,
      ));
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(markers.first.position.latitude, markers.first.position.longitude),
        destination: PointLatLng(markers.last.position.latitude, markers.last.position.longitude),
        mode: TravelMode.driving,
        wayPoints: polylineWayPoints,
      ),
      googleApiKey: apiKey,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    addPolyLine(polylineCoordinates);
    notifyListeners();
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    notifyListeners();
  }
}
