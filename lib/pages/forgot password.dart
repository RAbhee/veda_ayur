import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;

  Future<void> _requestOtp() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _navigateToHomePage();
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: $e");
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout, if needed
        },
      );
    } catch (e) {
      print("Error requesting OTP: $e");
      // Handle request OTP error
    }
  }

  Future<void> _verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      await _auth.signInWithCredential(credential);
      _navigateToHomePage();
    } catch (e) {
      print("Error verifying OTP: $e");
      // Handle OTP verification error
    }
  }

  void _navigateToHomePage() {
    // Navigate to the home screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    print("Navigate to home page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/bbggg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/background/logooo.png'),
                    height: 150,
                    width: 150,
                  ),
                ],
              ),
              Text(
                'Login Via OTP',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Names',
                  hintText: 'Enter your names',fillColor: Colors.white70, // Specify the background color here
                  filled: true,
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  fillColor: Colors.white70, // Specify the background color here
                  filled: true,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15,),

              // Request OTP button
              ElevatedButton(
                onPressed: _requestOtp,
                child: const Text('Request OTP'),
              ),
              SizedBox(height: 10,),

              // OTP input
              TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'OTP',
                  hintText: 'Enter the OTP',
                  fillColor: Colors.white70, // Specify the background color here
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),

              // Verify OTP button
              ElevatedButton(
                onPressed: _verifyOtp,
                child: const Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
