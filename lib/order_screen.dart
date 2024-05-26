import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pizza_app/poster.dart';
import 'package:pizza_app/userBloc/bloc/user_bloc.dart';
import 'package:uuid/uuid.dart';

class OrderFullScreen extends StatefulWidget {
  final double latie;
  final double long;
  String totalPrice;
  String location;
  OrderFullScreen(
      {required this.totalPrice,
      required this.location,
      required this.latie,
      required this.long,
      Key? key})
      : super(key: key);

  @override
  State<OrderFullScreen> createState() => _OrderFullScreenState();
}

class _OrderFullScreenState extends State<OrderFullScreen> {
 

  
  Completer<GoogleMapController> _completer = Completer();

  var uuid = Uuid();
  
  LocationData? currentLocation;
  double? distance;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(ProfileGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Order Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _completer.complete(controller);
                  },
                  polylines: {
                   
                  },
                  markers: {
                  
                    Marker(
                        markerId: MarkerId('3'),
                        position: LatLng(widget.latie, widget.long))
                  },
                  initialCameraPosition: CameraPosition(
                      zoom: 13.5, target: LatLng(widget.latie, widget.long)),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${distance?.toStringAsFixed(2)} KM",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "\$${widget.totalPrice}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            OfferCard(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://thumbs.dreamstime.com/z/vector-food-delivery-man-scooter-illustration-cartoon-character-courier-motorcycle-helmet-delivers-around-city-boy-176854830.jpg')),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pizza Hut Bangalore",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "somasundarapalaya,HSR layout",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 5,
                    color: Colors.black,
                    height: 30,
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is profileSuccesState) {
                        return Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          state.user!.profile)),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.user!.name}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "${widget.location}",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Text(
                                  "${state.user!.phone}",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            )
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  
  }
