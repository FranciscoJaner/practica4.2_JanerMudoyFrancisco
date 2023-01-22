import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

// Classe la cual es la pagina avon visualitzam las direccions.
class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'http');
  }
}
