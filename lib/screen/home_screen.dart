import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/components/car_card.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/view_details.dart';
import 'package:reksti/global/car_var.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/models/crash_detail.dart';
import 'package:reksti/pushNotification/push_notification_system.dart';
import 'package:reksti/screen/cars_list__screen.dart';
import 'package:reksti/screen/warning_history_screen.dart';
import 'package:reksti/widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference cars = FirebaseDatabase.instance.ref().child("cars");
  StreamSubscription<DatabaseEvent>? statusSubscription;

  void retrieveCarsData() {
    cars.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        carsMap = Map<String, dynamic>.from(data);
        List<CarsList> carsList = [];
        carsMap.forEach((key, value) {
          if (value is Map) {
            carsList
                .add(CarsList.fromMap(Map<String, dynamic>.from(value), key));
          }
        });
      }
    });
  }

  initializePushNotificationSystem() {
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.startListeningForNewNotification(context);
  }

  void listenToTripRequestStatus() {
    DatabaseReference driverTripStatusRef = FirebaseDatabase.instance
        .ref()
        .child("admins")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("status");

    statusSubscription = driverTripStatusRef.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (!(snapshot.value == "idle")) {
        PushNotificationSystem.retrieveTripRequestInfo(
            snapshot.value.toString(), context);
      }
      return;
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveCarsData();
    initializePushNotificationSystem();
    DatabaseReference initStatus = FirebaseDatabase.instance
        .ref()
        .child("admins")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("status");
    initStatus.set("idle");
    fetchCrashDetails();
    listenToTripRequestStatus();
  }

  @override
  void dispose() {
    statusSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 10,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: whiteColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Tracci',
          style: GoogleFonts.lalezar(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WarningHistoryScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: whiteColor,
                  backgroundColor: whiteColor,
                  disabledForegroundColor: kPrimaryColor.withOpacity(0.38),
                  disabledBackgroundColor: kPrimaryColor.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(width, height * 0.15),
                ),
                child: SizedBox(
                  width: width,
                  height: height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning,
                        color: kPrimaryColor,
                        size: 37,
                      ),
                      Text(
                        'Warnings',
                        style: primaryTextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cars',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarsListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'View All',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: normal,
                          decoration: TextDecoration.underline,
                          decorationColor: kPrimaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.65,
                width: width,
                child: StreamBuilder(
                  stream: cars.onValue,
                  builder: (context, snapshotData) {
                    if (snapshotData.hasError) {
                      return Center(
                        child: Text(
                          "Error Occurred.",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    if (!snapshotData.hasData ||
                        snapshotData.data!.snapshot.value == null) {
                      return Center(
                        child: Text(
                          "No record found.",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    Map dataCars = snapshotData.data!.snapshot.value as Map;
                    List<CarsList> carsList = [];
                    dataCars.forEach((key, value) {
                      if (value is Map) {
                        carsList.add(CarsList.fromMap(
                            Map<String, dynamic>.from(value), key));
                      }
                    });

                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: kIsWeb ? Axis.horizontal : Axis.vertical,
                      itemCount: carsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: kIsWeb ? width * 0.3 : double.infinity,
                            height: kIsWeb ? height * 0.1 : height * 0.3,
                            child: CarCard(
                              cars: carsList[index],
                              onPress: () => Navigator.pushNamed(
                                context,
                                ViewDetails.routeName,
                                arguments:
                                    ViewDetailsArguments(car: carsList[index]),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerBar(),
      endDrawerEnableOpenDragGesture: true,
    );
  }
}
