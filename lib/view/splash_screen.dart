import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Screen())); });

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(100),
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "TOP HEADLINES",
              style: GoogleFonts.anaheim(fontSize: 25, color: Colors.black,),

            ),
            const SizedBox(
              height: 20,
            ),
            const SpinKitChasingDots(
              size: 50,
              color: Colors.amberAccent,
            )
          ],
        ),
      ),
    );
  }
}
