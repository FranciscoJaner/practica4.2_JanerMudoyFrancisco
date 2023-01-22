import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller =
      Completer(); // Cream un controller.
  late GoogleMapController mapController; // Cream un segon controller.
  bool tipo = false;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntInicial = CameraPosition(
      // Cream un camera position y li pasam las cordenadas incial que ens pasen.
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    // Metode que a partir del valor de tipo, canviara el tipo de mapa.
    MapType maptype() {
      if (tipo == false) {
        return MapType.normal;
      } else {
        return MapType.hybrid;
      }
    }

    // Metode que coloca una marca a la posicio que indicam.
    Set<Marker> markers = new Set<Marker>();
    markers.add(
      Marker(
        markerId: const MarkerId('Mark1'),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            onPressed: (() {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: _puntInicial.target,
                      zoom:
                          15))); // A partir de el segon controller quan clicki el boto, moura la camera a la posicio inicial.
            }),
            icon: const Icon(Icons.location_pin),
          )
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: maptype(), // Cridam al metode que tenim abans.
        markers: markers,
        initialCameraPosition:
            _puntInicial, // Cridam que la posicio inicial sigui el metode puninicial.
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController =
              controller; // Quan el mapi es crei asiggnam al valor el controller.
        },
      ),
      floatingActionButton: Padding(
        // Boto el qual clickem canviara el valor de tipo, fent aixo que el tipo de mapa canvi gracies al metode que tenim abans.
        padding: const EdgeInsetsDirectional.only(end: 40),
        child: FloatingActionButton(
          onPressed: () {
            if (tipo) {
              tipo = false;
            } else {
              tipo = true;
            }
            setState(() {});
          },
          child: const Icon(Icons.map),
        ),
      ),
    );
  }
}
