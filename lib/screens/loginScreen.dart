
import 'package:finops/models/staticVar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class loginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for form validation
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Animate(
        effects: [FadeEffect(duration: Duration(milliseconds: 1000))],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left side: Icon/Illustration
                Expanded(
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all()),
                    width: staticVar.fullWidth(context) * .3,
                    height: staticVar.fullhigth(context),
                    child:   Image.asset('assets/login.png' ,width: 100,), // Replace with your asset
                  ),
                ),
                SizedBox(width: 50),

                // Right side: Form
                Expanded(
                  child: SizedBox(
                    width: 50,
                    child: Form(
                      key: _formKey, // Assigning the key to the Form widget
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo and title
                          Row(
                            children: [

                              Text(
                                'FINOPS',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: staticVar.themeColor
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),

                          // Email field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              hintText: 'Enter email address',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email.';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address.';
                              }
                              return null; // Return null if validation passes
                            },
                          ),
                          SizedBox(height: 20),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              hintText: 'Enter password',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your password.';
                              }
                              return null; // Return null if validation passes
                            },
                          ),
                          SizedBox(height: 20),

                          // Login button
                          ElevatedButton(
                            onPressed: isLoading ? null : _login,
                            child: Center(
                              child: isLoading
                                  ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                                  : Text(
                                'Log In',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Sharp edges
                              ),
                              backgroundColor:  staticVar.themeColor,
                              minimumSize: Size(double.infinity, 50),
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
        ),
      ),
    );
  }

// Function to handle login using Firebase
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, exit the function
    }

    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ).catchError((err){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(err.message),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });

      // Login successful
      print('Login successful: ${userCredential.user!.uid}');
      _showDialog('Login Successful', 'Welcome back!'); // Show success dialog

    }
    catch (e) {
      // Handle any other exceptions
      setState(() {
        isLoading = false;
      });
      print("Error $e");
  //    _showDialog('Login Failed', 'An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false; // Ensure loading is false after the attempt
      });
    }
  }

  // Function to show a dialog with feedback
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
