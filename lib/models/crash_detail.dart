import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrashDetails {
  String? crashID;

  LatLng? crashLatLng;
  String? crashAddress;

  String? carModel;
  String? platNomor;

  CrashDetails({
    this.crashID,
    this.crashLatLng,
    this.crashAddress,
    this.carModel,
    this.platNomor,
  });
}