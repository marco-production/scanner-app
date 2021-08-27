import 'package:flutter/material.dart';
import 'package:scanner/src/app/models/scanner.dart';

class MapPage extends StatelessWidget {

  final List<Scanner> scanners;

  MapPage({
    Key? key,
    required this.scanners
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: MapsList(scanners: scanners),
    );
  }
}

class MapsList extends StatelessWidget {

  final List<Scanner> scanners;

  MapsList({
    Key? key,
    required this.scanners
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: scanners.length,
        itemBuilder: (_, int index) {
          return ListTile(
            leading: Icon(Icons.location_on),
            title: Text(scanners[index].value),
            subtitle: Text('ID: ${scanners[index].id}'),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
            onTap: () => print('hola'),
          );
        }
    );
  }
}


