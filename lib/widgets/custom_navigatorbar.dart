import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  // Classe que crea al widget que tenim a la part inferior per poder seleccionar a quina pantalla volem anar.
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}
