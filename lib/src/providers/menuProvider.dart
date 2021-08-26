import 'package:flutter/cupertino.dart';

class MenuProvider extends ChangeNotifier {

  int _currentMenuIndex = 1;

  int get currentMenuIndex {
    return this._currentMenuIndex;
  }

  set currentMenuIndex( int index ) {
    _currentMenuIndex = index;
    notifyListeners();
  }

}
