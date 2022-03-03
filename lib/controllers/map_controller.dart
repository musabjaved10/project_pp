import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapController extends GetxController{

  Set<Marker> markers = {};


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