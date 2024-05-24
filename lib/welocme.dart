import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_app/strat_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 4), (timer) { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelocmeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 50,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                     Text(
                        'TO',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.green,
                            fontSize: 40,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900),
                      ),
                       Text(
                        'PIZZA HUT',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.green,
                            fontSize: 40,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900),
                      ),
                    SizedBox(height: 130,)
                  ],
                )
              ],
            ),
          ),
          Positioned(
              left: 250,
              bottom: 500,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/mozzarella.png")),
                  shape: BoxShape.circle, // Shape as circle
                ),
                child: Container(
                  width: 300,
                  height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              )),
          Positioned(
              right: 200,
              bottom: 500,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/prosciutto.png")),
                  shape: BoxShape.circle, // Shape as circle
                ),
                child: Container(
                  width: 300,
                  height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              )),
          Positioned(
              right: 60,
              bottom: 300,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/capricciosa.png")),
                  shape: BoxShape.circle, // Shape as circle
                ),
                child: Container(
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
