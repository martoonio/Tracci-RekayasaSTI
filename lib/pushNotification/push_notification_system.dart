import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/models/crash_detail.dart';
import 'package:reksti/widgets/loading_dialog.dart';
import 'package:reksti/widgets/notification_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationSystem {  
  FirebaseMessaging firebaseCloudMessaging = FirebaseMessaging.instance;

  Future<String?> generateDeviceRegistrationToken() async {
    String? deviceRecognitionToken = await firebaseCloudMessaging.getToken();

    DatabaseReference referenceOnlineAdmin = FirebaseDatabase.instance
        .ref()
        .child("admins")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("deviceToken");

    referenceOnlineAdmin.set(deviceRecognitionToken);

    firebaseCloudMessaging.subscribeToTopic("admins");
    firebaseCloudMessaging.subscribeToTopic("cars");
    return null;
  }

  startListeningForNewNotification(BuildContext context) async {
    ///1. Terminated
    //When the app is completely closed and it receives a push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? messageRemote) {
      if (messageRemote != null) {
        String crashID = messageRemote.data["crashID"];

        retrieveTripRequestInfo(crashID, context);
      }
    });

    ///2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? messageRemote) {
      if (messageRemote != null) {
        String crashID = messageRemote.data["crashID"];

        retrieveTripRequestInfo(crashID, context);
      }
    });

    ///3. Background
    //When the app is in the background and it receives a push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? messageRemote) {
      if (messageRemote != null) {
        String crashID = messageRemote.data["crashID"];

        retrieveTripRequestInfo(crashID, context);
      }
    });
  }

  static retrieveTripRequestInfo(String crashID, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "getting details..."),
    );

    // Navigator.pop(context);

    DatabaseReference crashRef =
        FirebaseDatabase.instance.ref().child("crash").child(crashID);

    crashRef.once().then((dataSnapshot) {
      Navigator.pop(context);

      audioPlayer.open(
        Audio("audio/notif.mp3"),
      );

      audioPlayer.play();

      CrashDetails crashDetailsInfo = CrashDetails();
      double crashLat = double.parse(
          (dataSnapshot.snapshot.value! as Map)["crashLatLng"]["latitude"]);
      double crashLng = double.parse(
          (dataSnapshot.snapshot.value! as Map)["crashLatLng"]["longitude"]);
      crashDetailsInfo.crashLatLng = LatLng(crashLat, crashLng);

      crashDetailsInfo.crashAddress =
          (dataSnapshot.snapshot.value! as Map)["crashAddress"];

      crashDetailsInfo.carModel =
          (dataSnapshot.snapshot.value! as Map)["carModel"];
      crashDetailsInfo.platNomor =
          (dataSnapshot.snapshot.value! as Map)["platNomor"];

      crashDetailsInfo.crashID = crashID;

      showDialog(
        context: context,
        builder: (BuildContext context) => NotificationDialog(
          crashDetailsInfo: crashDetailsInfo,
        ),
      );
    });
  }
}
