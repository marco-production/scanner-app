import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  //MapScreen({Key key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final Scanner scanner =
        ModalRoute.of(context)!.settings.arguments as Scanner;
    final geo = scanner.value.split(':');
    final location = geo[1].split(',');

    double log = double.parse(location[0].trim());
    double lat = double.parse(location[1].trim());

    Completer<GoogleMapController> _controller = Completer();

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(log, lat),
      zoom: 17,
    );

    Set<Marker> marker = Set<Marker>();
    marker.add(new Marker(
      markerId: MarkerId('location-id'),
      position: LatLng(log, lat),
    ));

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Location'),
        actions: [
          IconButton(icon: Icon(Icons.location_searching),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(log, lat),
                  zoom: 17
                )
              ));
            })
        ],
      ),
      body: GoogleMap(
        mapType: _mapType,
        markers: marker,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.auto_awesome_motion),
        onPressed: (){
          setState(() {
            _mapType == MapType.normal ? _mapType = MapType.hybrid : _mapType = MapType.normal;
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
