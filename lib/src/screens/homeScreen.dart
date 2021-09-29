import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/pages/directionPage.dart';
import 'package:scanner/src/pages/mapPage.dart';
import 'package:scanner/src/providers/menuProvider.dart';
import 'package:scanner/src/providers/scannerProvider.dart';
import 'package:scanner/src/utils/launchItem.dart';
import 'package:scanner/src/widgets/customBottomNavigationBar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuProvider = Provider.of<MenuProvider>(context);
    final scannerProvider = Provider.of<ScannerProvider>(context, listen: false);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(menuProvider.currentMenuTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.restore_from_trash),
              onPressed: () => scannerProvider.deleteScanners())
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
          
          if (!barcodeScanRes.contains('http') && !barcodeScanRes.contains('geo:')) {
            _showAlert(context);
          } else {
            menuProvider.currentMenuIndex = barcodeScanRes.contains('http') ? 1 : 0;
            scannerProvider.addScanner(barcodeScanRes).then((value) => launchItem(context, value));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showAlert(BuildContext context)
  {
       showDialog(
          context: context,
          builder: (BuildContext builder){
            return AlertDialog(
              title: Row(children: <Widget>[
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 5,),
                Text('Error'),
              ],),
              content: Text("QR code isn't valid."),
              actions: <Widget>[
                TextButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('Close'))
              ],
          );
      });
  }
}

class CurrentPage extends StatelessWidget {
  CurrentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final menuProvider = Provider.of<MenuProvider>(context);
    final scannerProvider = Provider.of<ScannerProvider>(context);

    int currentPageIndex = menuProvider.currentMenuIndex;

    switch(currentPageIndex){

      case 0:

        scannerProvider.scannerListByType('location');
        final scanners = scannerProvider.scanners;
        return MapPage(scanners: scanners);

      case 1:

        scannerProvider.scannerListByType('url');
        final scanners = scannerProvider.scanners;
        return DirectionPage(scanners: scanners);

      default:

        scannerProvider.scannerListByType('location');
        final scanners = scannerProvider.scanners;
        return MapPage(scanners: scanners);
    }

  }
}

