import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen(
      {required this.name,
      required this.email,
      required this.gender,
      required this.number,
      Key? key})
      : super(key: key);

  String name, number, gender, email;

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
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
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: AnimatedPadding(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.only(top: _offset),
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Adjusted top padding
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Set password',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text("Set your password",
                        style: TextStyle(color: Colors.black45)),
                  ],
                ),
                SizedBox(height: 30), // Space between text and form
                TextFormField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("At least 1 number or a spechial character",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(height: 50), // Space before the button
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                signwithemailandpasswordEvent(
                                    password: passwordController.text,
                                    name: widget.name,
                                    gender: widget.gender,
                                    email: widget.email,
                                    number: widget.number,
                                    context: context));
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if(state is LoadingState){
                                return Center(
                                child:CircularProgressIndicator()
                              );
                              }else{
                                return Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              );
                              }
                            },
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
        ),
      ),
    );
  }
}
