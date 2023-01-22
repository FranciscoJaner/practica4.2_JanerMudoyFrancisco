import 'package:flutter/cupertino.dart';

// Classe provider que ens notifica quan canviam de menu i o actualitza.
class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}
