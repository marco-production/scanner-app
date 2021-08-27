import 'package:flutter/cupertino.dart';

class MenuProvider extends ChangeNotifier {

  int _currentMenuIndex = 0;
  String _currentTitle = 'Maps';
  Map<int, String> _mapTitles = {
    0: 'Maps',
    1: 'Direcctions'
  };

  int get currentMenuIndex {
    return this._currentMenuIndex;
  }

  String get currentMenuTitle {
    return this._currentTitle;
  }

  set currentMenuIndex( int index ) {
    _currentMenuIndex = index;
    _currentTitle = this._mapTitles[index]!;
    notifyListeners();
  }

}
