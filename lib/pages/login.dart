
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:veda_ayur/pages/forgot password.dart';
  import 'homepage.dart';

  class LoginPage extends StatelessWidget {
    LoginPage({super.key});

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController passwordcontroller = TextEditingController();
    final TextEditingController emailController = TextEditingController();



    void _login (BuildContext context) async {
      if (_formKey.currentState!.validate()) {
        try {

          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordcontroller.text,
          );

          print("Login successful");
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );

        } catch (e) {
          // Handle login errors
          print("Login failed: $e");

        }
      }
    }


    @override
    Widget build(BuildContext context) {
      void _login (BuildContext context) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }

      void _forgotPassword (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
        );
      }
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/bbggg.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/background/logooo.png'),
                          height: 150,width: 150,),
                      ],
                    )
                ),
                Text('Login Page',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),),
                SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as',
                    fillColor: Colors.white70, // Specify the background color here
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                    fillColor: Colors.white70, // Specify the background color here
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () => _login(context),

                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    shadowColor: Colors.red,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text('Login'),
                ),

                TextButton(
                  onPressed: () => _forgotPassword(context),
                  child: const Text('Login Via otp',
                  style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,fontSize: 15),),),
              ],

            ),
          ),
        ),
      );

    }
  }