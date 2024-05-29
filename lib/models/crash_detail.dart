import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrashDetails {
  String? crashID;
  String? carID;
  LatLng? crashLatLng;
  String? crashAddress;
  String? carModel;
  String? platNomor;
  String? date;

  CrashDetails({
    this.crashID,
    this.carID,
    this.crashLatLng,
    this.crashAddress,
    this.carModel,
    this.platNomor,
    this.date,
  });
}

List<CrashDetails> crashDetailsList = [];

void fetchCrashDetails() async {
  DatabaseReference crashHistoryList =
      FirebaseDatabase.instance.ref().child("crash");

  crashHistoryList.once().then((DatabaseEvent event) {
    if (event.snapshot.value != null) {
      Map<String, dynamic> crashes =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      crashes.forEach((key, value) {
        Map<String, dynamic> crashData = Map<String, dynamic>.from(value);

        CrashDetails crashDetails = CrashDetails(
          crashID: key,
          carID: crashData["carID"],
          crashLatLng: LatLng(crashData["latitude"], crashData["longitude"]),
          crashAddress: crashData["crashAddress"],
          carModel: crashData["model"],
          platNomor: crashData["platNomor"],
          date: crashData["date"],
        );

        crashDetailsList.add(crashDetails);
      });
    }
  }).catchError((error) {
    print("Error fetching crash details: $error");
  });
}
