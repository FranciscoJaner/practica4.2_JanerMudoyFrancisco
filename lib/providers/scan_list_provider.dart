import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  // Classe provider amb la cual agafare els valors de la base de dades i els introduirem dintre de una llista per poder visualitzarlos, es una clase provider perque quan alguna cosa canvii o poguem visualitzar.
  List<ScanModel> scans = []; // Cream la llista.
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  // Carregam tots els valors de la base de dades i els introduim dintre de la llista.
  carregarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  // Carregam els valors a la llsita a partir del seu tipus.
  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  // Metode que esborra tots els valors de la llista.
  esborraTots() async {
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  // Metode que borra de la llista el valor a partir del seu id.
  esborraPerId(int id) async {
    final scans = await DBProvider.db.deleteScan(id);
    this.scans.removeAt(scans);
    this.notifyListeners();
  }
}
