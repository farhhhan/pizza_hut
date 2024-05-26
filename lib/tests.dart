// import 'dart:async';
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:pizza_app/poster.dart';
// import 'package:pizza_app/userBloc/bloc/user_bloc.dart';
// import 'package:uuid/uuid.dart';

// class OrderFullScreen extends StatefulWidget {
//   final double latie;
//   final double long;
//   String totalPrice;
//   String location;
//   OrderFullScreen(
//       {required this.totalPrice,
//       required this.location,
//       required this.latie,
//       required this.long,
//       Key? key})
//       : super(key: key);

//   @override
//   State<OrderFullScreen> createState() => _OrderFullScreenState();
// }

// class _OrderFullScreenState extends State<OrderFullScreen> {
//   double _degreesToRadians(double degrees) {
//     return degrees * math.pi / 180;
//   }

//   List<LatLng> polycordinates = [];
//   final locationController = TextEditingController();
//   final searchLocationcontroller = TextEditingController();
//   List<Marker> _marker = [];
//   List<Marker> _list = [];
//   List<dynamic> _placeList = [];
//   LatLng source = LatLng(12.899695672590374, 77.64910455351989);
//   LatLng destination = LatLng(12.901176793444089, 77.65124869541353);
//   static const CameraPosition _kLake = CameraPosition(
//     bearing: 192.8334901395799,
//     target: LatLng(37.43296265331129, -122.08832357078792),
//     tilt: 59.440717697143555,
//     zoom: 14,
//   );
//   Completer<GoogleMapController> _completer = Completer();

//   var uuid = Uuid();
//   String _sessionToken = '';
//   LocationData? currentLocation;
//   double? distance;

//   @override
//   void initState() {
//     super.initState();
//     getPolyPoints();
//     context.read<UserBloc>().add(ProfileGetEvent());
//     distance = calculateDistance(
//         source.latitude, source.longitude, widget.latie, widget.long);
//   }

//   void getCurrentLocation() async {
//     Location location = Location();

//     try {
//       bool serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) {
//           return;
//         }
//       }

//       PermissionStatus permissionGranted = await location.hasPermission();
//       if (permissionGranted == PermissionStatus.denied) {
//         permissionGranted = await location.requestPermission();
//         if (permissionGranted != PermissionStatus.granted) {
//           return;
//         }
//       }

//       LocationData locData = await location.getLocation();
//       setState(() {
//         currentLocation = locData;
//       });

//       GoogleMapController _googlemapController = await _completer.future;
//       _googlemapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(locData.latitude!, locData.longitude!),
//           zoom: 13.5,
//         ),
//       ));

//       location.onLocationChanged.listen((LocationData newLoc) {
//         _googlemapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//                 zoom: 13.5,
//                 target: LatLng(newLoc.latitude!, newLoc.longitude!)),
//           ),
//         );
//         setState(() {
//           currentLocation = newLoc;
//         });
//       });
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               expandedHeight: 300.0,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 title: Text("Order Details",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.0,
//                     )),
//                 background: GoogleMap(
//                   onMapCreated: (GoogleMapController controller) {
//                     _completer.complete(controller);
//                   },
//                   polylines: {
//                     Polyline(
//                         polylineId: PolylineId('1'),
//                         points: polycordinates,
//                         color: Colors.black,
//                         width: 5)
//                   },
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('1'),
//                       position: source,
//                     ),
//                     Marker(
//                         markerId: MarkerId('3'),
//                         position: LatLng(widget.latie, widget.long))
//                   },
//                   initialCameraPosition: CameraPosition(
//                       zoom: 13.5, target: LatLng(widget.latie, widget.long)),
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: ListView(
//           padding: EdgeInsets.all(16.0),
//           children: [
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       "Distance",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     Text(
//                       "${distance?.toStringAsFixed(2)} KM",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "Total Price",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     Text(
//                       "\$${widget.totalPrice}",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             OfferCard(),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: NetworkImage(
//                                     'https://thumbs.dreamstime.com/z/vector-food-delivery-man-scooter-illustration-cartoon-character-courier-motorcycle-helmet-delivers-around-city-boy-176854830.jpg')),
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                       SizedBox(width: 10),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Pizza Hut Bangalore",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           Text(
//                             "somasundarapalaya,HSR layout",
//                             style: TextStyle(fontSize: 11),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     width: 5,
//                     color: Colors.black,
//                     height: 30,
//                   ),
//                   SizedBox(height: 16),
//                   BlocBuilder<UserBloc, UserState>(
//                     builder: (context, state) {
//                       if (state is profileSuccesState) {
//                         return Row(
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: NetworkImage(
//                                           state.user!.profile)),
//                                   borderRadius: BorderRadius.circular(20)),
//                             ),
//                             SizedBox(width: 10),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${state.user!.name}",
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                                 SizedBox(
//                                   width: 200,
//                                   child: Text(
//                                     "${widget.location}",
//                                     style: TextStyle(fontSize: 11),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${state.user!.phone}",
//                                   style: TextStyle(fontSize: 11),
//                                 )
//                               ],
//                             )
//                           ],
//                         );
//                       } else {
//                         return Row(
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                   color: Colors.orange,
//                                   borderRadius: BorderRadius.circular(20)),
//                             )
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow',
//       PointLatLng(source.latitude, source.longitude),
//       PointLatLng(widget.latie, widget.long),
//     );
//     if (result.points.isNotEmpty) {
//       polycordinates.clear();
//       result.points.forEach((PointLatLng point) {
//         polycordinates.add(LatLng(point.latitude, point.longitude));
//       });
//       setState(() {});
//     }
//   }

//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     const earthRadius = 6371; // Radius of the Earth in kilometers
//     final dLat = _degreesToRadians(lat2 - lat1);
//     final dLon = _degreesToRadians(lon2 - lon1);
//     final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
//         math.cos(_degreesToRadians(lat1)) *
//             math.cos(_degreesToRadians(lat2)) *
//             math.sin(dLon / 2) *
//             math.sin(dLon / 2);
//     final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
//     return earthRadius * c;
//   }
// }
