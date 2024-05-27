import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OfferCard extends StatefulWidget {
  const OfferCard({Key? key}) : super(key: key);

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment
                .bottomLeft, // Aligns children to the bottom of the stack
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '50% OFF',
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 22),
                              ),
                              Text(
                                'Super Value',
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 22),
                              ),
                              Text(
                                "Chicken Tikka",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 130,
                child: Center(
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
              ),
              Positioned(
                bottom: 50,
                right: 20,
                child: Container(
                    height: 180,
                    child: Image.asset('assets/images/mozzarella.png')),
              )
            ],
          )
        ],
      ),
    );
  }
}
