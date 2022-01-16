import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project_pp/providers/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const routeName = '/maps';


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late BitmapDescriptor myIcon;

// make sure to initialize before map loading
  

  late Set<Marker> markers = new Set();
  final List<Marker> loadedMarkers = [];
   getPointMarkers() async{
    final url = Uri.parse('https://point-pay-a430e-default-rtdb.firebaseio.com/NED.json');
    try{
      final response = await http.get(url);
      // if(response.body == 'null'){
      //   print('haha');
      //   return;
      // }

      var extractedData = json.decode(response.body);
      for(var i=1;i<extractedData.length;i++){
        // print(myIcon);
        loadedMarkers.add(Marker(
              markerId: MarkerId(extractedData[i]['point_no'].toString()),
              position: LatLng(extractedData[i]['lat'], extractedData[i]['long']), //position of marker
              infoWindow: InfoWindow( //popup info
                title: 'My Custom Title ',
                snippet: 'My Custom Subtitle',
              ),
              icon: myIcon,
            ));
      }
      markers=  loadedMarkers.toSet();
      // print(markers);




      // extractedData.forEach((id, markerData) {
      //   print(markerData);
      //   if(prodData !=null){
      //   loadedMarkers.add(Marker(
      //     markerId: MarkerId(extractedData['point_id']),
      //     position: LatLng(24.8852602, 67.1774464), //position of marker
      //     infoWindow: InfoWindow( //popup info
      //       title: 'My Custom Title ',
      //       snippet: 'My Custom Subtitle',
      //     ),
      //     ),
      //     icon: BitmapDescriptor.defaultMarker,
      //   ));
      // };
      // });
    }catch(e){
      print(e);
      print('oops');
    }
  }
  @override
  void initState() {
    super.initState();

    () async{
      ByteData byteData = await DefaultAssetBundle.of(context).load("assets/icons/bus-icon.png");
      Uint8List imageData = byteData.buffer.asUint8List();
      myIcon = BitmapDescriptor.fromBytes(imageData);

      // BitmapDescriptor.fromAssetImage(
      //     ImageConfiguration(size: Size(12, 12)), 'assets/icons/bus-icon.png')
      //     .then((onValue) {
      //   myIcon = onValue;
      // });
      await getPointMarkers().then((value){
        setState(() {
          return;
        });
      });
    }();
  }



  // Location location = new Location();
  //
  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // late LocationData _locationData;
  //
  // _serviceEnabled = await location.serviceEnabled();
  // if (!_serviceEnabled) {
  // _serviceEnabled = await location.requestService();
  // if (!_serviceEnabled) {
  // return;
  // }
  // }
  //
  // _permissionGranted = await location.hasPermission();
  // if (_permissionGranted == PermissionStatus.denied) {
  // _permissionGranted = await location.requestPermission();
  // if (_permissionGranted != PermissionStatus.granted) {
  // return;
  // }
  // }
  //
  // _locationData = await location.getLocation();

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(24.8852602, 67.1774464);
  late Marker marker;

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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
        markers: markers != null ? markers : Set.of([]),
      ),
    );
  }
}
