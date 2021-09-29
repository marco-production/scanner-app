import 'package:flutter/material.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/widgets/pageData.dart';

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
      body: pageData(scanners: scanners),
    );
  }
}