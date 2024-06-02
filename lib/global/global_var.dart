import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference carsListAvailable =
    FirebaseDatabase.instance.ref().child("cars");

final crashHistoryList =
    FirebaseDatabase.instance.ref().child("crash");

DatabaseReference admins = FirebaseDatabase.instance.ref().child("admins");

String userName = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String userEmail = FirebaseAuth.instance.currentUser!.email!;

String googleMapKey = "AIzaSyDlN7pUZ_oPhroD-gHODW-f6uQ1sR6fH4Y";

final audioPlayer = AssetsAudioPlayer();

// Position? crashPosition;

String carName = "";
String carModel = "";
String carNumber = "";
String carYear = "";

Map<String, dynamic> carsMap = {};
