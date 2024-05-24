import 'package:flutter/material.dart';
import 'package:pizza_app/loginscreen.dart';
import 'package:pizza_app/sign_up.dart';

class WelocmeScreen extends StatefulWidget {
  const WelocmeScreen({Key? key}) : super(key: key);

  @override
  State<WelocmeScreen> createState() => _WelocmeScreenState();
}

class _WelocmeScreenState extends State<WelocmeScreen> {
  double _offset = 50.0; // Initial offset for animation

  @override
  void initState() {
    super.initState();
    // Animate the offset to 0 over 500 milliseconds
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _offset = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedPadding(
              duration: Duration(seconds: 1),
              padding: EdgeInsets.only(bottom: _offset),
              curve: Curves.easeInOut,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welocme",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Have a better sharing experience",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 160),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Container(
                            height: 65,
                            width: 500,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Create an accout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Container(
                          height: 65,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.green,
                              width: 3, // Adjust the width as needed
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 250,
            bottom: 600,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mozzarella.png"),
                ),
                shape: BoxShape.circle, // Shape as circle
              ),
              child: Container(
                width: 300,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            right: 200,
            bottom: 530,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/prosciutto.png"),
                ),
                shape: BoxShape.circle, // Shape as circle
              ),
              child: Container(
                width: 300,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            right: 70,
            bottom: 440,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mas1.png"),
                ),
                // Shape as circle
              ),
              child: Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: 380,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mas2.png"),
                ),
                // Shape as circle
              ),
              child: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
