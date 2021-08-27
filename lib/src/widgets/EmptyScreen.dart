import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {

  final IconData icon;

  const EmptyScreen({
    Key? key,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 70, color: Colors.grey,),
          Text('There are no records in the database.', style: TextStyle(fontSize: 16, color: Colors.grey),)
        ],
      ),
    );
  }
}
