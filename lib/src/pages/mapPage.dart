import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/providers/scannerProvider.dart';

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

    final scannerProvider = Provider.of<ScannerProvider>(context, listen: false);

    // TODO: implement build
    return ListView.builder(
        itemCount: scanners.length,
        itemBuilder: (_, int index) {

          Scanner scanner = scanners[index];
          return Dismissible(
            key: Key('scanner ${scanners[index].id}'),
            background: Container(
              color: Colors.red[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(Icons.delete_forever_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
            onDismissed: (DismissDirection direction){
              scannerProvider.deleteScannerById(scanner.id!);
            },
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(scanner.value),
              subtitle: Text('ID: ${scanner.id}'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () => print('hola'),
            ),
          );
        }
    );
  }
}


