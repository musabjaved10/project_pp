import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'service.dart';
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

  @override
  void initState() {
    super.initState();
  }
  @override
  void didUpdateWidget(MapScreen oldWidget) {

      setState((){
       return;
      });

    super.didUpdateWidget(oldWidget);
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
      body: StreamBuilder(
          stream: Service().markerStream(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
                markers: snapshot.data,
              );
            }

              return Center(child: CircularProgressIndicator(),);

          }
      )
      // GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
      //   markers: markers != null ? markers : Set.of([]),
      // ),
    );
  }
}
