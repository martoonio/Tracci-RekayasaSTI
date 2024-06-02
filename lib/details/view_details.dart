import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/car_detail.dart';
import 'package:reksti/global/car_var.dart';
import 'package:reksti/models/crash_detail.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class ViewDetails extends StatelessWidget {
  static String routeName = "/view";

  ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ViewDetailsArguments;
    final car = agrs.car;

    final Completer<GoogleMapController> googleMapCompleterController =
        Completer<GoogleMapController>();
    GoogleMapController? controllerGoogleMap;
    LatLng? crashLatLng;
    Set<Marker> markers = {};

    return Scaffold(
      appBar: AppBar(
        title: Text(
          car.platNomor,
          style: GoogleFonts.jost(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: whiteColor,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: CarDetailsArguments(car: car),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance.ref().child("crash").once(),
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData &&
              snapshot.data!.snapshot.value != null) {
            Map<String, dynamic> crashData =
                Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
            List<CrashDetails> crashDetailsList = [];
            crashData.forEach((key, value) {
              var crashDetail = Map<String, dynamic>.from(value);
              crashDetailsList.add(CrashDetails(
                crashID: key,
                carID: crashDetail["carID"],
                crashLatLng:
                    LatLng(crashDetail["latitude"], crashDetail["longitude"]),
                carModel: crashDetail["model"],
                platNomor: crashDetail["platNomor"],
                date: crashDetail["date"],
              ));
            });

            List<Appointment> getAppointments() {
              List<Appointment> meetings = <Appointment>[];
              DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

              for (int i = 0; i < crashDetailsList.length; i++) {
                if (crashDetailsList[i].carID == car.key) {
                  String dateString = crashDetailsList[i].date!;
                  DateTime dateTime = format.parse(dateString);
                  final DateTime startTime = DateTime(dateTime.year,
                      dateTime.month, dateTime.day, dateTime.hour, 0, 0);
                  final DateTime endTime =
                      startTime.add(const Duration(hours: 1));

                  meetings.add(Appointment(
                    // location: crashDetails.crashAddress,
                    startTime: startTime,
                    endTime: endTime,
                    subject: 'Suspicious Activity Detected!',
                    color: const Color(0xFFFF5B5B),
                    recurrenceRule: 'FREQ=DAILY;COUNT=1',
                    isAllDay: false,
                  ));
                }
              }

              print("Total appointments: ${meetings.length}");
              return meetings;
            }

            // Pastikan crashDetailsList tidak kosong dan memiliki elemen yang sesuai
            if (crashDetailsList.isNotEmpty) {
              CrashDetails? firstCrashDetail = crashDetailsList.firstWhere(
                  (element) => element.carID == car.key,
                  orElse: () => CrashDetails(
                      crashID: '',
                      carID: '',
                      crashLatLng: LatLng(0, 0),
                      carModel: '',
                      platNomor: '',
                      date: ''));

              // Periksa apakah firstCrashDetail valid
              if (firstCrashDetail.carID!.isNotEmpty) {
                crashLatLng = firstCrashDetail.crashLatLng;

                markers.add(
                  Marker(
                    markerId: const MarkerId("crashLocation"),
                    position: crashLatLng!,
                    infoWindow: InfoWindow(
                      title: "Crash Location",
                      snippet: car.platNomor,
                    ),
                  ),
                );
              }
            }

            return Column(
              children: [
                Container(
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-6.2088, 106.8456),
                      zoom: 12,
                    ),
                    markers: markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) async {
                      controllerGoogleMap = controller;
                      googleMapCompleterController.complete(controller);

                      if (crashLatLng != null) {
                        controllerGoogleMap!.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: crashLatLng!,
                              zoom: 18,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.69,
                  child: SfCalendar(
                    view: CalendarView.day,
                    dataSource: MeetingDataSource(getAppointments()),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                      showAgenda: true,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No crash history found for this car.'),
            );
          }
        },
      ),
    );
  }
}

class ViewDetailsArguments {
  final CarsList car;

  ViewDetailsArguments({required this.car});
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
