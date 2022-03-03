import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_pp/controllers/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const routeName = '/maps';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController getxMapController = Get.find<MapController>();
  DatabaseReference ref = FirebaseDatabase.instance.ref("NED");
  late BitmapDescriptor myIcon;

// make sure to initialize before map loading

  @override
  void initState() {
    if(mounted) {
      ref.onValue.listen((event) async {
        final data = event.snapshot.value;
        await getxMapController.updateMarkers(context, data);
      });
      super.initState();
    }

  }





  late GoogleMapController mapController;
  final LatLng _center = const LatLng(24.8852602, 67.1774464);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Points Tracking'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: GetBuilder<MapController>(
          init: MapController(),
          builder: (controller) =>
          controller.markers.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: _center, zoom: 14.0),
                markers: controller.markers,
              )
        )



        // GoogleMap(
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
        //   markers: markers != null ? markers : Set.of([]),
        // ),
        );
  }
}
