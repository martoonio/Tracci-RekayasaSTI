import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/view_details.dart';
import 'package:reksti/global/car_var.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/methods/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:reksti/models/crash_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDialog extends StatefulWidget {
  CrashDetails? crashDetailsInfo;

  NotificationDialog({
    super.key,
    this.crashDetailsInfo,
  });

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  String tripRequestStatus = "";
  CommonMethods cMethods = CommonMethods();
  // CarsList? car;

  @override
  void initState() {
    super.initState();
  }

  checkAvailabilityOfTripRequest(BuildContext context) async {
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => LoadingDialog(
    //     messageText: 'please wait...',
    //   ),
    // );

    // // Navigator.pop(context);

    // DatabaseReference driverTripStatusRef = FirebaseDatabase.instance
    //     .ref()
    //     .child("admins")
    //     .child(FirebaseAuth.instance.currentUser!.uid)
    //     .child("status");

    // await driverTripStatusRef.once().then((snap) {
    //   Navigator.pop(context);
    //   Navigator.pop(context);

    //   String newTripStatusValue = "";
    //   if (snap.snapshot.value != null) {
    //     newTripStatusValue = snap.snapshot.value.toString();
    //   } else {
    //     cMethods.displaySnackBar("Trip Request Not Found.", context);
    //   }

    //   if (newTripStatusValue == widget.crashDetailsInfo!.crashID) {
    //     driverTripStatusRef.set("accepted");
    //   } else if (newTripStatusValue == "cancelled") {
    //     cMethods.displaySnackBar(
    //         "Trip Request has been Cancelled by user.", context);
    //   } else if (newTripStatusValue == "timeout") {
    //     cMethods.displaySnackBar("Trip Request timed out.", context);
    //   } else {
    //     cMethods.displaySnackBar("Trip Request removed. Not Found.", context);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: whiteColor,
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Suspicious deceleration detected!",
              style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Image(
                width: 108,
                height: 108,
                image: AssetImage(
                  "images/warning 1.png",
                )),
            const SizedBox(
              height: 20.0,
            ),
            //pick - dropoff
            // Center(
            // padding: const EdgeInsets.all(16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //pickup
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage("images/Car.png"),
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${widget.crashDetailsInfo?.platNomor.toString()} (${widget.crashDetailsInfo!.carModel})",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.jost(
                          color: blackColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                //dropoff
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: blackColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${widget.crashDetailsInfo!.crashLatLng!.latitude}, ${widget.crashDetailsInfo!.crashLatLng!.longitude}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.jost(
                          color: blackColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // ),
            //decline btn - accept btn
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 0, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse("tel://110"),
                        );
                        admins
                            .child(FirebaseAuth.instance.currentUser!.uid)
                            .child("status")
                            .set("idle");
                        Navigator.pop(context);
                        audioPlayer.stop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          side: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "Call 110",
                        style:
                            GoogleFonts.jost(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        audioPlayer.stop();
                        admins
                            .child(FirebaseAuth.instance.currentUser!.uid)
                            .child("status")
                            .set("idle");
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          side: const BorderSide(
                            color: kPrimaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "View",
                        style: GoogleFonts.jost(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
