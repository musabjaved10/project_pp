import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class Service{

     getPointMarkers(BuildContext context) async{
      final url = Uri.parse('https://point-pay-a430e-default-rtdb.firebaseio.com/NED.json');
      ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/bus-icon.png");
      Uint8List imageData = byteData.buffer.asUint8List();
      BitmapDescriptor myIcon = BitmapDescriptor.fromBytes(imageData);
      final response = await http.get(url);

        Set<Marker> markers = new Set();
        List<Marker> loadedMarkers = [];
        try{
          var extractedData = json.decode(response.body);
          for(var i=1;i<extractedData.length;i++){
            // print(myIcon);
            loadedMarkers.add(Marker(
              markerId: MarkerId(extractedData[i]['point_no'].toString()),
              position: LatLng(extractedData[i]['lat'], extractedData[i]['long']), //position of marker
              infoWindow: InfoWindow( //popup info
                title: "Point ${extractedData[i]['point_no']}",

              ),
              icon: myIcon,
            ));
          }
          markers=  loadedMarkers.toSet();
          return markers;

        }catch(e){
          print(e);
          print('oops');
        }

    }

     Stream<Set<Marker>> markerStream(context) async* {
       while (true) {
         await Future.delayed(Duration(milliseconds: 500));
         Set<Marker> markers = await getPointMarkers(context);
         print('hello');
         yield markers;
       }
     }
}

