import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/models/crash_detail.dart';

class WarningHistoryScreen extends StatefulWidget {
  static String routeName = "/warning_history";

  const WarningHistoryScreen({super.key});

  @override
  State<WarningHistoryScreen> createState() => _WarningHistoryScreenState();
}

class _WarningHistoryScreenState extends State<WarningHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 10,
        centerTitle: true,
        title: Text(
          'Warning History',
          style: GoogleFonts.lalezar(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: whiteColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: crashHistoryList.onValue,
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

            return Container(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              height: height * 0.9,
              width: double.infinity,
              child: ListView.builder(
                itemCount: crashDetailsList.length,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(crashDetailsList[index].date!);
                  return ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.car_rental)),
                    title: Text("Deceleration warning"),
                    subtitle: Text(
                        DateFormat('MMMM d, yyyy - hh:mm a').format(dateTime)),
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   DetailsScreen.routeName,
                      //   arguments: CarDetailsArguments(car: carsList[index]),
                      // );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
