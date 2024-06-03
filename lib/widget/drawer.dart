import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/authentication/login_screen.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/screen/cars_list__screen.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'tracci',
                style: primaryTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.web_sharp,
                  color: blackColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Dashboard',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: normal,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          // SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.car_rental,
                  color: blackColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Cars',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: normal,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarsListScreen(),
                ),
              );
              // Then close the drawer
              // Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.person,
                  color: blackColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Account',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: normal,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                Text(
                  'Logout',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: normal,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            onTap: () {
              //logout
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
