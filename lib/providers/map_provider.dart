import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapProvider with ChangeNotifier{

  late Set<Marker> markers = new Set();

  Future<dynamic> getPointMarkers() async{
    final url = Uri.parse('https://point-pay-a430e-default-rtdb.firebaseio.com/NED.json');
    try{
      final response = await http.get(url);
      if(response.body == 'null'){
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData); return;
      if(extractedData == null) {
        return;
      }
      final List<Marker> loadedMarkers = [];
      extractedData.forEach((prodId, prodData) {
        loadedMarkers.add(Marker(
          markerId: MarkerId(extractedData['point_id']),
          position: LatLng(24.8852602, 67.1774464), //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'My Custom Title ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    }catch(e){

    }
  }
}