
import 'package:flutter/cupertino.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/providers/dbProvider.dart';

class ScannerProvider extends ChangeNotifier {

  List<Scanner> scanners = [];
  String scannerType = 'http';

  scannerList() async
  {
    final scannersList = await DBProvider.db.getScanners();
    this.scanners = [...scannersList];
    notifyListeners();
  }

  scannerListByType(String type) async
  {
    final scannersList = await DBProvider.db.getScannersByType(type);

    this.scannerType = type;
    this.scanners = [...scannersList];

    notifyListeners();
  }

  addScanner(String value) async
  {
    final scanner = Scanner(value: value);
    final addScanner = await DBProvider.db.insertScanner(scanner);

    scanner.id = addScanner;

    if(this.scannerType == scanner.type) {
      this.scanners.add(scanner);
      notifyListeners();
    }
  }

  deleteScanners() async
  {
    await DBProvider.db.DeleteScanners();

    scanners = [];
    notifyListeners();
  }

  deleteScannerById(int id) async
  {
    final deleteScanner = await DBProvider.db.DeleteScannerById(id);

    scanners.removeWhere((element) => element.id == deleteScanner);
    notifyListeners();
  }

}