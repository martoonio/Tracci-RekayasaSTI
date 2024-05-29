import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/methods/common_methods.dart';
import 'package:flutter/material.dart';

class CobaDialog extends StatefulWidget {
  // CrashDetails? crashDetailsInfo;

  const CobaDialog({
    super.key,
    // this.crashDetailsInfo,
  });

  @override
  State<CobaDialog> createState() => _CobaDialogState();
}

class _CobaDialogState extends State<CobaDialog> {
  String tripRequestStatus = "";
  CommonMethods cMethods = CommonMethods();

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
                        "B 1234 ABC (Honda Brio)",
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
                        "6°55′41.124″LS,107°46′13.62″BT",
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

                        setState(() {
                          tripRequestStatus = "accepted";
                        });

                        checkAvailabilityOfTripRequest(context);
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
