import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/src/providers/menuProvider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuProvider = Provider.of<MenuProvider>(context);

    // TODO: implement build
    return BottomNavigationBar(
        currentIndex: menuProvider.currentMenuIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index){
          menuProvider.currentMenuIndex = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Maps',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi),
              label: 'Directions'
          ),
        ]
    );
  }
}
