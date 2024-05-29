import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/components/rent_card.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/car_var.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/global/rent_var.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CarDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as CarDetailsArguments;
    final car = agrs.car;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Tracci',
          style: GoogleFonts.lalezar(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.35,
            width: double.infinity,
            child: Image.asset(
              'images/brio.webp',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Container(
            height: kIsWeb ? height * 0.35 : height * 0.25,
            width: kIsWeb ? 500 : double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Car Description',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Kendaraan',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car.model,
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tipe",
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car.tipe,
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tahun',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car.tahun,
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plat Nomor',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car.platNomor,
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                Text(
                  'Rental History',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RentCard(
                  rent: demoRentVars[0],
                ),
                RentCard(
                  rent: demoRentVars[1],
                ),
                RentCard(
                  rent: demoRentVars[2],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          //delete cars button
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        carsListAvailable.child(car.key).remove();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Delete Device',
                        style: GoogleFonts.jost(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class CarDetailsArguments {
  final CarsList car;

  CarDetailsArguments({required this.car});
}
