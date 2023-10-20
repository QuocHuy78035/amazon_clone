import 'package:flutter/foundation.dart';

class BottomNavProvider extends ChangeNotifier{
  int _indexPage = 0;

  int get indexPage => _indexPage;

  void setIndex(int index){
    _indexPage = index;
    notifyListeners();
  }
}