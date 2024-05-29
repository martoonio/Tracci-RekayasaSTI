import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reksti/global/global_var.dart';

import '../constants.dart';
import '../global/car_var.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.cars,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final CarsList cars;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: GestureDetector(
          onTap: onPress,
          child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Container(
                    height: kIsWeb ? height * 0.5 : height * 0.24,
                    width: kIsWeb ? width * 0.3 : double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Image.asset(
                      "images/brio.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    height: kIsWeb ? height * 0.1 : height * 0.05,
                    width: kIsWeb ? width * 0.3 : double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      cars.platNomor,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
