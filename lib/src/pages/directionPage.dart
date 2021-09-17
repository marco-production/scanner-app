import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/providers/scannerProvider.dart';

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

    final scannerProvider = Provider.of<ScannerProvider>(context, listen: false);

    // TODO: implement build
    return ListView.builder(
        itemCount: scanners.length,
        itemBuilder: (_, index) {

          Scanner scanner = scanners[index];
          return Dismissible(
            key: Key('scanner ${scanner.id.toString()}'),
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
            onDismissed: (DismissDirection direction) {
              scannerProvider.deleteScannerById(scanner.id!);
            },
            direction: DismissDirection.startToEnd,
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


