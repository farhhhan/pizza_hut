import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/accountsucces.dart';
import 'package:pizza_app/home.dart';
import 'package:pizza_app/otpscreen.dart';
import 'package:pizza_app/passwords.dart';


 String imageurl='https://littleooties.ca/wp-content/uploads/2022/07/AdobeStock_64672736_Preview.jpg';
class FirebaseAuthentServices {
  String? verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<User?> signUpWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Error signing up: $e');
      throw Exception('Error signing up: $e');
    }
  }

  Future<User?> signInWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> phoneNumberAuth(String number, String email, String name,
      String gender, BuildContext context) async {
    final phoneNumber = number;
    print(phoneNumber);
    try {
      if (phoneNumber.length == 10) {
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91$phoneNumber",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Verification Failed: ${e.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Verification Failed: ${e.message}'),
              ),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  verificationId: verificationId,
                  email: email,
                  gender: gender,
                  name: name,
                  number: number,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
          },
        );
      } else {
        print('Please enter a valid phone number');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid phone number'),
          ),
        );
      }
    } catch (e) {
      print('Error verifying phone number: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying phone number: $e'),
        ),
      );
    }
  }

  Future<void> checkingOtp(String otp, String name, String gender, String email,
      String number, String verificationId, BuildContext context) async {
    try {
      FirebaseAuth.instance.getRedirectResult();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordScreen(
              email: email,
              gender: gender,
              name: name,
              number: number,
            ),
          ),
        );
      });
    } catch (ex) {
      print(ex.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying phone number: $ex'),
        ),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context, bool isUser) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        print(user);

        if (user != null && isUser) {
          await firestore.collection("users").doc(user.uid).set({
            "uid": user.uid,
            "Name": user.displayName,
            "Email": user.email,
            "profile": user.photoURL,
            'Gender':'No declared',
            'phone':'+91000000000',
            'password':'signwithgoogle',
          });
        }
      }
    } catch (e) {
      print("Exception is: $e");
    }
  }

//  void forgetPassword(String email) async {
//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: email)
//           .onError((error, stackTrace) {
//         utils().showToast(error.toString());
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
  Future<void> registerUser({
    required BuildContext context,
    required String email,
    required String username,
    required String phoneNumber,
    required String password,
    required String gender,
  }) async {
    print('hellow check 1');
    final db = FirebaseFirestore.instance;
    User? user = await signUpWithEmailandPassword(
      email: email,
      password: password,
    );

    if (user != null) {
      print('User Successfully Created');
      try {
        final data = <String, String>{
          "Name": username,
          "Email": email,
          "phone": phoneNumber,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'Gender':gender,
          'password':password,
          'profile':imageurl

        };

        // Save user data to Firestore

        print('hellow check 3');
        await db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(data);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => craeteSuccesScreen(),
            ),
            (route) => false);

        // Navigate to next screen
      } catch (e) {
        // Handle storage errors
        print('Error uploading image: $e');
        // You may want to show an error message to the user here
      }
    } else {
      print('Something went wrong during user creation');
      // You may want to show an error message to the user here
    }
  }

  void signIn(String email, String password, BuildContext context) async {
    await signInWithEmailandPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Succesfully'),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login have error :$error'),
        ),
      );
    });
  }
}
