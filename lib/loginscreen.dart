import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _offset = 0.0;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  

  @override
  Widget build(BuildContext context) {
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
                        "Sign In with your email or",
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "phone number",
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 30),
                     
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 30,),
                       TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                       
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forget Password? ',style: TextStyle(color: Colors.red),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/tick.png")),
                          Text(
                            "By signing up, you agree to the ",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Terms of Service",
                            style: TextStyle(color: Colors.green, fontSize: 10),
                          ),
                          Text(
                            " and",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            " Privacy Policy",
                            style: TextStyle(color: Colors.green, fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignInevent(email: _emailController.text, password: _passwordController.text, context: context));
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
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Divider(
                              height: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text("Or"),
                          ),
                          SizedBox(
                            width: 150,
                            child: Divider(
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 2, // Adjust the width as needed
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                child: Image.asset('assets/images/gmail.png'),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Sign with Gmail",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          Text(
                            "Sign Up ",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
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
}
