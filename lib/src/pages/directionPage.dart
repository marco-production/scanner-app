import 'package:flutter/material.dart';
import 'package:scanner/src/app/models/scanner.dart';

class DirectionPage extends StatelessWidget {

  final List<Scanner> scanners;

  DirectionPage({
    Key? key,
    required this.scanners
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      //EmptyScreen(icon: Icons.link)
      body: DirectionsList(scanners: scanners),
    );
  }
}

class DirectionsList extends StatelessWidget {

  final List<Scanner> scanners;

  DirectionsList({
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


