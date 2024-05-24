import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';
import 'package:pizza_app/image/img_bloc_bloc.dart';
import 'package:pizza_app/model/userModel.dart';
import 'package:pizza_app/userBloc/bloc/user_bloc.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({required this.user, Key? key}) : super(key: key);
  UserModel user;
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];
  double _offset = 0.0;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set initial offset to 50 for example
    _offset = 50.0;
    // Animate the offset to 0 over 500 milliseconds
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _offset = 0.0;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Regex for basic email validation
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Basic phone number validation (for simplicity, just check length here)
    if (value.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateGender(String? value) {
    if (value == null) {
      return 'Please select your gender';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _selectedGender = widget.user.gender;
    _phoneController.text = widget.user.phone;
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSendSuccess) {
            // Handle success state here if needed
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred. Please try again.')),
            );
          }
        },
        child: AnimatedPadding(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.only(top: _offset),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit your profile",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Edit here",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          BlocBuilder<ImgBlocBloc, ImgBlocState>(
                            builder: (context, state) {
                              Widget imageWidget;

                              if (state.file == null ||
                                  state.file!.isEmpty ||
                                  state.file![0] == null) {
                                imageWidget = CircleAvatar(
                                  maxRadius: 60,
                                  backgroundImage:
                                      NetworkImage(widget.user.profile),
                                );
                              } else {
                                imageWidget = CircleAvatar(
                                  maxRadius: 60,
                                  backgroundImage:
                                      FileImage(File(state.file![0].path)),
                                );
                              }

                              return Align(
                                alignment: Alignment.center,
                                child: imageWidget,
                              );
                            },
                          ),
                          Positioned(
                              top: 88,
                              right: 120,
                              child: InkWell(
                                onTap: () {
                                  _showBottomSheet(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  maxRadius: 15,
                                  child: Center(
                                      child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 18,
                                  )),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateName,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 20),
                      IntlPhoneField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        validator: (value) {
                          return _validatePhone(value?.number);
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: _selectedGender,
                        items: _genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                        validator: _validateGender,
                      ),
                      SizedBox(height: 60),
                      BlocBuilder<ImgBlocBloc, ImgBlocState>(
                        builder: (contexts, state) {
                          return InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<UserBloc>().add(
                                  profileEditEvent(
                                    context: context,
                                    email: widget.user.email,
                                    gender: _selectedGender.toString(),
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    profile: state.file![0]?.path.toString() ??
                                        widget.user.profile,
                                    uid: widget.user.uid));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: BlocBuilder<UserBloc, UserState>(
                                builder: (context, states) {
                                  if (states is loadingState ) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        "Save change",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<ImgBlocBloc, ImgBlocState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(camerPickerEvent());
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.camera),
                    title: Text('Take Form Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(gellaryPickerEvent());
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.browse_gallery),
                    title: Text('Take Form Gellary'),
                  ),
                ],
              );
            },
          );
        });
  }
}
