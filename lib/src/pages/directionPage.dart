import 'package:flutter/material.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:scanner/src/widgets/pageData.dart';

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
      body: pageData(scanners: scanners),
    );
  }
}

