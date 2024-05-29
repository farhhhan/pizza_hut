import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pizza_app/location/bloc/autho_complete_bloc.dart';
import 'package:pizza_app/model/cartModel.dart';
import 'package:pizza_app/order_screen.dart';

class AddMapScreen extends StatefulWidget {
  AddMapScreen({required this.lists,Key? key, required this.totol});
  String totol;
  List<CartModel> lists;
  
  @override
  State<AddMapScreen> createState() => _AddMapScreenState();
}

class _AddMapScreenState extends State<AddMapScreen> {
  final locationController = TextEditingController();
  LocationData? currentLocation;
  List<Marker> _marker = [];
  List<Marker> _list = [];
  final searchLocationcontroller = TextEditingController();
  CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 14,
  );
  Completer<GoogleMapController> _completer = Completer();
  double? currentLatitude;
  double? currentLongitude;

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  dynamic first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "Select Location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Center(
                  child: InkWell(
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      if (currentLatitude != null && currentLongitude != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderFullScreen(
                              latie: currentLatitude!,
                              long: currentLongitude!,
                              location: searchLocationcontroller.text,
                              totalPrice: widget.totol,
                            ),
                          ),
                        );
                      } else {
                        print("Location not selected.");
                      }
                    },
                  ),
                ),
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Delivery To",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You selected Location show Here",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  child: ListView(
                                    children: [
                                      Text(
                                        "${searchLocationcontroller.text}",
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 212, 209, 209),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.white54),
                        BoxShadow(color: Colors.black12),
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              )),
          Positioned(
            top: 0,
            bottom: 190,
            left: 0,
            right: 0,
            child: BlocBuilder<AuthoCompleteBloc, AuthoCompleteState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        print(state.markerlist);
                        _completer.complete(controller);
                      },
                      initialCameraPosition: _kLake,
                      markers: Set<Marker>.of(_list),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () {
                              getCurrentLocation();
                            },
                            child: CircleAvatar(
                              maxRadius: 30,
                              child: Center(
                                child: Icon(
                                  Icons.my_location_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                ),
                Positioned(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          BlocBuilder<AuthoCompleteBloc, AuthoCompleteState>(
                            builder: (context, state) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          context.read<AuthoCompleteBloc>().add(
                                              AuthoCompleteLoadedEvent(
                                                  serachInput: value));
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10.0),
                                          hintText: "Search Location",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[300]!),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            size: 22,
                                            color: Colors.black,
                                          ),
                                        ),
                                        controller: searchLocationcontroller,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 48.00,
                                      height: 48.00,
                                      decoration: BoxDecoration(
                                        color: Colors.amber[400],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Icon(
                                        Icons.filter_list,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: BlocBuilder<AuthoCompleteBloc,
                                AuthoCompleteState>(
                              builder: (context, state) {
                                if (state is AuthoCompleteLoading) {
                                  return SizedBox();
                                } else if (state is AuthoCompleteLoaded) {
                                  return Container(
                                    height: 300,
                                    color: state.authocomplete.isEmpty
                                        ? Colors.transparent
                                        : searchLocationcontroller.text.isEmpty
                                            ? Colors.transparent
                                            : Colors.white,
                                    child: ListView.builder(
                                      itemCount: state.authocomplete.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            searchLocationcontroller.text =
                                                state.authocomplete[index]
                                                    ['description'];
                                            List location = await Geocoder.local
                                                .findAddressesFromQuery(
                                                    state.authocomplete[index]
                                                        ['description']);
                                            first = location.first;

                                            setState(() {
                                              currentLatitude = first
                                                  .coordinates.latitude!
                                                  .toDouble();
                                              currentLongitude = first
                                                  .coordinates.longitude!
                                                  .toDouble();
                                              _list.add(Marker(
                                                markerId: MarkerId('1'),
                                                position: LatLng(
                                                    currentLatitude!,
                                                    currentLongitude!),
                                                infoWindow: InfoWindow(
                                                    title: 'Searched Location'),
                                              ));
                                            });

                                            context
                                                .read<AuthoCompleteBloc>()
                                                .add(afterGetEvent());

                                            GoogleMapController controller =
                                                await _completer.future;
                                            controller.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                              zoom: 12,
                                              target: LatLng(currentLatitude!,
                                                  currentLongitude!),
                                            )));
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderFullScreen(
                                                  latie: currentLatitude!,
                                                  long: currentLongitude!,
                                                  location:
                                                      searchLocationcontroller
                                                          .text,
                                                  totalPrice: widget.totol,
                                                ),
                                              ),
                                            );
                                          },
                                          title: Text(state.authocomplete[index]
                                              ['description']),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: Text('Error Occurred'),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getCurrentLocation() async {
    Location location = Location();

    try {
      // Request location permissions if not granted
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return; // Location services are still not enabled, exit
        }
      }

      // Check for permission
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return; // Location permission not granted, exit
        }
      }

      // Get the current location
      LocationData locData = await location.getLocation();
      setState(() {
        currentLocation = locData;
        currentLatitude = locData.latitude!;
        currentLongitude = locData.longitude!;
        // Add marker at current location
        _list.add(Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(currentLatitude!, currentLongitude!),
          infoWindow: InfoWindow(title: 'Current Location'),
        ));
      });

      // Reverse geocode the current location coordinates to get the address
      final coordinates = Coordinates(currentLatitude!, currentLongitude!);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      setState(() {
        searchLocationcontroller.text = first.addressLine ?? '';
      });

      GoogleMapController _googlemapController = await _completer.future;
      _googlemapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLatitude!, currentLongitude!),
          zoom: 13.5,
        ),
      ));

      // Listen for location changes
      location.onLocationChanged.listen((LocationData newLoc) async {
        setState(() {
          currentLocation = newLoc;
          currentLatitude = newLoc.latitude!;
          currentLongitude = newLoc.longitude!;
          // Update marker position on location change
          _list = _list.map((marker) {
            if (marker.markerId == MarkerId('current_location')) {
              return Marker(
                markerId: marker.markerId,
                position: LatLng(currentLatitude!, currentLongitude!),
                infoWindow: marker.infoWindow,
              );
            }
            return marker;
          }).toList();
        });
        _googlemapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(currentLatitude!, currentLongitude!),
            ),
          ),
        );

        // Reverse geocode the updated coordinates to get the address
        final newCoordinates = Coordinates(currentLatitude!, currentLongitude!);
        var newAddresses =
            await Geocoder.local.findAddressesFromCoordinates(newCoordinates);
        var newFirst = newAddresses.first;
        setState(() {
          searchLocationcontroller.text = newFirst.addressLine ?? '';
        });
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
