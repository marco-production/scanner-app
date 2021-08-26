import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/pages/directionPage.dart';
import 'package:scanner/src/pages/mapPage.dart';
import 'package:scanner/src/providers/dbProvider.dart';
import 'package:scanner/src/providers/menuProvider.dart';
import 'package:scanner/src/widgets/customBottomNavigationBar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
              icon: Icon(Icons.restore_from_trash),
              onPressed: (){})
        ],
      ),

      body: CurrentPage(),

      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.qr_code_sharp),
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#FFFFFF',
              'Cancel',
              false,
              ScanMode.DEFAULT);

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CurrentPage extends StatelessWidget {
  CurrentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final menuProvider = Provider.of<MenuProvider>(context);

    int currentPageIndex = menuProvider.currentMenuIndex;

    //final scanner = Scanner(value: "https://www.youtube.com/");
    //DBProvider.db.insertScanner(scanner);
    //DBProvider.db.getScannerById(8).then((value) => value != null ? print(value.value) : print('El Id no coincide con los registros.'));
    final list = DBProvider.db.getScanners().then((value) => {

      value.forEach((element) {
        print(element.value);
      })

    });

    switch(currentPageIndex){

      case 0:
        return MapPage();

      case 1:
        return DirectionPage();

      default:
        return MapPage();
    }

  }
}

class _HomeScreen extends StatelessWidget {
  _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('Home Screen'),
    );
  }
}


