import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(
        tipus:
            'geo'); // Classe la cual es visualitzaram els valors de tipus geo.
  }
}
