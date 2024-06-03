import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/authentication/login_screen.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/global_var.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController admin = TextEditingController(text: adminName);
  TextEditingController email = TextEditingController(text: adminEmail);
  @override
  Widget build(BuildContext context) {
    print("ini nama admin $adminName");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 10,
        centerTitle: true,
        title: Text(
          'Account',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(
                Icons.account_circle,
                size: 100,
                color: kPrimaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Admin Name",
                  style: GoogleFonts.jost(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                Container(
                  width: 400,
                  height: 38,
                  child: TextFormField(
                    controller: admin,
                    style: GoogleFonts.jost(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: blackColor,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.jost(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                Container(
                  width: 400,
                  height: 38,
                  child: TextFormField(
                    controller: email,
                    style: GoogleFonts.jost(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: blackColor,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Logout",
                style: GoogleFonts.jost(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
