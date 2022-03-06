import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:geolocator/geolocator.dart';
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
  late StreamSubscription _liveStream;
  late Position _position;

// make sure to initialize before map loading

  @override
  void initState() {
    _activeListeners();

    getxMapController.getLocation();

    super.initState();
  }

  void _activeListeners() {
    _liveStream = ref.onValue.listen((event) async {
      final data = event.snapshot.value;
      getxMapController.updateMarkers(context, data);
    });
  }

  @override
  void deactivate() {
    _liveStream.cancel();
    super.deactivate();
  }

  // late GoogleMapController mapController;
  final mapController = Completer<GoogleMapController>();
  final LatLng _center = const LatLng(24.8852602, 67.1774464);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Points Tracking'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        floatingActionButton: Obx(() =>getxMapController.locPermission.value == false && getxMapController.locService.value == false ? FloatingActionButton(
          onPressed: () {
            getxMapController.getLocation();
          },
          child: const Icon(Icons.location_on),
          backgroundColor: Colors.lightBlueAccent,
        ): Container()),
        body: GetBuilder<MapController>(
            init: MapController(),
            builder: (controller) => controller.markers.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Animarker(
                    shouldAnimateCamera: false,
                    useRotation: false,
                    mapId:
                        mapController.future.then<int>((value) => value.mapId),
                    markers: controller.markers,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                      onMapCreated: (gController) {
                        mapController.complete(gController);
                        print("printing getx ${getxMapController.position}");
                        //Complete the future GoogleMapController
                      },
                      initialCameraPosition: CameraPosition(
                          target: controller.position == null
                              ? _center
                              : LatLng(controller.position.latitude,
                                  controller.position.longitude),
                          zoom: 14.0),
                    ),
                  ))

        // GoogleMap(
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
        //   markers: markers != null ? markers : Set.of([]),
        // ),
        );
  }
}
