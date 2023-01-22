import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

import '../providers/ui_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              // Cridam el metode la classe scanlistprovider, perque quan clickem el boto es borrin tots el valors de la llista.
              Provider.of<ScanListProvider>(context, listen: false)
                  .esborraTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aqui el que feim basicament es segons la opccio que clickem ens obrira una pagina o una altra i segons la pagina que sigui ens carregara uns valors de la llista o uns altres.
    final uiProvider = Provider.of<UiProvider>(context);

    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context,
        listen: false); // Cridam el provider.

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScansPerTipus('geo'); // Carregam per geo.
        return MapasScreen();

      case 1:
        scanListProvider.carregaScansPerTipus('http'); // Carregam per http
        return DireccionsScreen();

      default:
        scanListProvider.carregaScansPerTipus('geo'); // Carregam per geo.
        return MapasScreen();
    }
  }
}
