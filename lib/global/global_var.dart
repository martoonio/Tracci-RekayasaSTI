import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

DatabaseReference carsListAvailable =
    FirebaseDatabase.instance.ref().child("cars");

String userName = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String userEmail = FirebaseAuth.instance.currentUser!.email!;

final audioPlayer = AssetsAudioPlayer();

// Position? crashPosition;

String carName = "";
String carModel = "";
String carNumber = "";
String carYear = "";

Map<String, dynamic> carsMap = {};
