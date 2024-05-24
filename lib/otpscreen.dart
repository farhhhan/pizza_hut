import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';
import 'package:pizza_app/passwords.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String email;
  final String gender;
  final String name;
  final String number;

  OtpScreen({
    Key? key,
    required this.verificationId,
    required this.email,
    required this.gender,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  double _offset = 50.0; // Initial offset for animation

  // Create a list of TextEditingControllers for each OTP input field
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

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
  void dispose() {
    // Dispose all the controllers when the screen is disposed
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildOtpInput({required int index}) {
    return Container(
      width: 50,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body:  AnimatedPadding(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.only(top: _offset),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Adjusted top padding
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Phone Verification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("Enter your OTP", style: TextStyle(color: Colors.black)),
                ],
              ),
              SizedBox(height: 30), // Space between text and form
              Form(
                key: formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(6, (index) => buildOtpInput(index: index)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Did not receive the OTP? ",
                      style: TextStyle(color: Colors.black)),
                  Text("Resend", style: TextStyle(color: Colors.green)),
                ],
              ),
              SizedBox(height: 50), // Space before the button
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: InkWell(
                          onTap: () {
                             if (formKey.currentState!.validate()) {
                            String otp =
                                _otpControllers.map((e) => e.text).join();
                            try {
                              context.read<AuthBloc>().add(verificationOtpEvent(
                                    otp: otp,
                                    verificationId: widget.verificationId,
                                    number: widget.number,
                                    email: widget.email,
                                    gender: widget.gender,
                                    name: widget.name,
                                    context: context,
                                  ));
                            } catch (ex) {
                              print(ex.toString());
                            }
                          }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                     ),
                    
                  ],
                ),
              ),
              Spacer(), // Pushes content up
            ],
          ),
        ),
      );
  }
}
