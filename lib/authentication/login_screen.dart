import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reksti/authentication/signup_screen.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/global/global_var.dart';
import 'package:reksti/methods/common_methods.dart';
import 'package:reksti/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CommonMethods cMethods = CommonMethods();

  bool _passwordVisible = false;

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);
    signInFormValidation();
  }

  signInFormValidation() {
    if (!emailTextEditingController.text.contains("@")) {
      cMethods.displaySnackBar("please write valid email.", context);
    } else if (passwordTextEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar(
          "your password must be atleast 6 or more characters.", context);
    } else {
      signInUser();
    }
  }

  signInUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      User? userFirebase = userCredential.user;

      if (!context.mounted) return;

      Navigator.pop(context);

      if (userFirebase != null) {
        DatabaseReference usersRef = FirebaseDatabase.instance
            .ref()
            .child("admins")
            .child(userFirebase.uid);

        usersRef.once().then((snap) {
          if (snap.snapshot.value != null) {
            userName = (snap.snapshot.value as Map)["name"];
            userEmail = (snap.snapshot.value as Map)["email"];
            kIsWeb
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()))
                : Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()));
          } else {
            FirebaseAuth.instance.signOut();
            cMethods.displaySnackBar(
                "your record does not exist as an Admin.", context);
          }
        });
      }
    } catch (errorMsg) {
      if (!context.mounted) return;

      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "RideWave",
          style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 40,
              // ),

              // Image.asset(
              //   "images/cover.png",
              //   width: 220,
              // ),

              const SizedBox(
                height: 30,
              ),

              //text fields + button
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  key: _formKey,
                  children: [
                    TextFormField(
                      controller: emailTextEditingController,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kPrimaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                            color: Colors.white,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      controller: passwordTextEditingController,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                            color: Colors.white,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ForgotPassword(),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF054C67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register!",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}