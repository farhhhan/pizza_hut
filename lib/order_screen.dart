import 'dart:async';
import 'dart:ffi';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pizza_app/cartbloc/bloc/cart_bloc.dart';
import 'package:pizza_app/home.dart';
import 'package:pizza_app/poster.dart';
import 'package:pizza_app/userBloc/bloc/user_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class OrderFullScreen extends StatefulWidget {
  final double latie;
  final double long;
  String totalPrice;
  String location;
  OrderFullScreen({
    required this.totalPrice,
    required this.location,
    required this.latie,
    required this.long,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderFullScreen> createState() => _OrderFullScreenState();
}

class _OrderFullScreenState extends State<OrderFullScreen> {
  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  Completer<GoogleMapController> _completer = Completer();

  var uuid = Uuid();

  LocationData? currentLocation;
  double? distance;
  double deliveryCharge = 0.0;

  @override
  void initState() {
    super.initState();
    calculateDeliveryCharge();
  }

  void calculateDeliveryCharge() {
    LatLng source = LatLng(widget.latie, widget.long);
    double sourceLatitude = source.latitude;
    double sourceLongitude = source.longitude;
    double destinationLatitude = 12.899695672590374;
    double destinationLongitude = 77.64910455351989;

    double distanceInKm = calculateDistance(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude,
    );

    if (distanceInKm <= 5) {
      deliveryCharge = 40;
    } else {
      // Calculate additional charge for each 2 km beyond the first 5 km
      double additionalCharge = ((distanceInKm - 5) / 2).ceil() * 20;
      deliveryCharge = 40 + additionalCharge;
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // Radius of the Earth in kilometers
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  @override
  Widget build(BuildContext context) {
    double strprice = double.parse(widget.totalPrice);
    double total = strprice + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Container(
            height: 200,
            width: 300,
            child: Stack(
              children: [
                Positioned(
                  bottom: 1,
                  child: Container(
                      height: 350,
                      child: Image.asset('assets/images/mozzarella.png')),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Offers :"),
          ),
          OfferCard(),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("You Selected Location :"),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
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
                      child: ClipPath(
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _completer.complete(controller);
                          },
                          markers: {
                            Marker(
                              markerId: MarkerId('3'),
                              position: LatLng(widget.latie, widget.long),
                            )
                          },
                          initialCameraPosition: CameraPosition(
                            zoom: 13.5,
                            target: LatLng(widget.latie, widget.long),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 130,
                      child: Center(
                        child: Text(
                          "Location",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 96, 87, 87),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total :'),
                      Text('\$${widget.totalPrice}'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charge :'),
                      Text('\$${deliveryCharge.toString()}'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount :'),
                      Text('\$${total.toString()}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                   Razorpay razorpay = Razorpay();
                  var options = {
                    'key':'rzp_test_1DP5mmOlF5G5ag',
                    // 'key': 'rzp_test_fJdcDyzohkOCPb',
                    'amount': 100,
                    'name': 'Pizza Hut.',
                    'description': 'Pizza Delivery',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '+919074139842',
                      'email': 'farhanfarhu60@gmail.com'
                    },
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorpay.open(options);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartAddLoadingEvent) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "PayNow",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
  
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    print(response.data.toString());
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
        
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
