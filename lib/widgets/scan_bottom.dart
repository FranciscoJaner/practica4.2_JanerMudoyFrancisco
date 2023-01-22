import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

import '../models/scan_model.dart';

class ScanButton extends StatelessWidget {
  // Classe la qual crea el boto que tenim com una de las opcions.
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        // Quan el polsem assignara un valor per defecte o obrira la camera per escanegar un qr.
        print('Botó polsat!');
        String barcodeScanRes = 'geo:39.7260847,2.9113035';
        //String barcodeScanRes = 'https://paucasesnovescifp.cat';

        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( // Aixo el que fa es obrir la camera per escanegar un qr.
        //  '#3D88EF', 'Cancel·lar', false, ScanMode.QR);

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context, nouScan);
      },
    );
  }
}
