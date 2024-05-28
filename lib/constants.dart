import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffffffff);
Color blackColor = const Color(0xff000000);
Color textColor = const Color(0xffffffff);
Color secondaryTextColor = const Color(0xffffffff);
Color primaryButtonColor = const Color(0x00054c67);
Color buttonColor = const Color.fromARGB(0, 255, 255, 255);
const kPrimaryColor = Color(0xFF73C2FB);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF82A5B3), Color(0xFF054C67)],
);
const kSecondaryColor = Color(0xff0078c9);
const kTextColor = Color(0xFF757575);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);
TextStyle blackTextStyle = GoogleFonts.poppins(
  color: blackColor,
);
TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);
TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

FontWeight bold = FontWeight.bold;
FontWeight normal = FontWeight.normal;
