import 'package:flutter/cupertino.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void launchItem(BuildContext context, Scanner scanner) async {

  final value = scanner.value;

  if(value.contains('http'))
  {
    await canLaunch(value) ? await launch(value) : throw 'Could not launch $value';
  }
  else
  {
    Navigator.of(context).pushNamed('/map', arguments: scanner);
  }
}
