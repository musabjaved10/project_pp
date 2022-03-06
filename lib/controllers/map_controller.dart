import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapController extends GetxController{

  Set<Marker> markers = {};
  var position ;


  getLocation() async{
    try{
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      position = await Geolocator.getCurrentPosition();
      print("Printing the position${position}");
      update();
      return;
    }catch(e){
      Get.snackbar('Error', '$e', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.lightBlueAccent);
    }
  }


  updateMarkers(BuildContext context, data) async{
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/bus-icon.png");
    Uint8List imageData = byteData.buffer.asUint8List();
    BitmapDescriptor myIcon = BitmapDescriptor.fromBytes(imageData);

    List<Marker> loadedMarkers = [];
    try{
      for(var i=1;i<data.length;i++){
        // print(myIcon);
        loadedMarkers.add(Marker(
          markerId: MarkerId(data[i]['point_no'].toString()),
          position: LatLng(data[i]['lat'], data[i]['long']), //position of marker
          infoWindow: InfoWindow( //popup info
            title: "Point ${data[i]['point_no']}",
          ),
          icon: myIcon,
        ));
      }
      markers=  loadedMarkers.toSet();
      print('hello');
      update();

    }catch(e){
      print(e);
      print('oops');
    }

  }

}