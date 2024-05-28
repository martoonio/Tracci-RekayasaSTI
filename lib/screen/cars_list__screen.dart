import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/car_detail.dart';
import 'package:reksti/global/car_var.dart';
import 'package:reksti/global/global_var.dart';

class CarsListScreen extends StatefulWidget {
  const CarsListScreen({Key? key}) : super(key: key);

  @override
  State<CarsListScreen> createState() => _CarsListScreenState();
}

class _CarsListScreenState extends State<CarsListScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 10,
        centerTitle: true,
        title: Text(
          'Cars List',
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
          stream: carsListAvailable.onValue,
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
                carsList.add(
                    CarsList.fromMap(Map<String, dynamic>.from(value), key));
              }
            });

            return Container(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              height: height * 0.9,
              width: double.infinity,
              child: ListView.builder(
                itemCount: carsList.length,
                itemBuilder: (context, index) {
                  final platNomor = carsList.map((e) => e.platNomor).toList();
                  final model = carsList.map((e) => e.model).toList();
                  return ListTile(
                    leading: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.car_rental)),
                    title: Text(model[index]),
                    subtitle: Text(platNomor[index]),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: CarDetailsArguments(car: carsList[index]),
                      );
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
