import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/rent_var.dart';

class RentCard extends StatelessWidget {
  const RentCard({Key? key, required this.rent}) : super(key: key);
  final RentVar rent;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: whiteColor,
      child: Container(
        width: 272,
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: kPrimaryColor, size: 19),
                    const SizedBox(width: 10),
                    Text(
                      rent.name,
                      style: GoogleFonts.jost(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                      size: 19,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      rent.phoneNum.toString(),
                      style: GoogleFonts.jost(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  color: kPrimaryColor,
                  size: 19,
                ),
                const SizedBox(width: 10),
                Text(
                  "${rent.dateStart} - ${rent.dateEnd}",
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
