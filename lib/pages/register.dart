import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Form is valid, proceed with registration
        await FirebaseFirestore.instance.collection('users').add({
          'name': nameController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
        });
        _login(context);
      } catch (e) {
        print('Error storing data in Firestore: $e');
        // Handle the error appropriately (show a message, log it, etc.)
      }
    }
  }

  void _login(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/background/logooo.png'),
                        height: 150,
                        width: 150,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 25),
              TextFormField(

                controller: nameController,
                decoration:
                InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your names',
                  suffixIcon: Icon(Icons.person),
                  fillColor: Colors.white70, // Specify the background color here
                  filled: true,

                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height:10,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  suffixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white70, // Specify the background color here
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white70, // Specify the background color here
                  filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  suffixIcon: Icon(Icons.phone_android),
                  hintText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
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
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _registerUser(context);
                },
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () => _login(context),
                child: Text(
                  'Already Registered?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
