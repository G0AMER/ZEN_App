import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _zenIDCard = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _obscureText = true;
  bool _obscureTextt = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign up successfully'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred';
        if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'An account already exists for this email.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backkk.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), // Adjust the opacity here
              BlendMode.dstATop, // Blend mode to apply the transparency
            ),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            constraints: BoxConstraints(
              maxWidth: 600.0,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Title
                    Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.brown.shade900, // Deep brown color
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Playfair Display', // Elegant font
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    //full name field
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.person, color: Colors.brown.shade700),
                        labelText: 'Full name',
                        labelStyle: TextStyle(color: Colors.brown.shade700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade900),
                        ),
                      ),
                      style: TextStyle(color: Colors.brown.shade900),
                      onChanged: (value) => _fullName = value,
                      cursorColor: Colors.brown.shade900,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.card_giftcard,
                            color: Colors.brown.shade700),
                        labelText: 'Zen ID Card Number',
                        labelStyle: TextStyle(color: Colors.brown.shade700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade900),
                        ),
                      ),
                      style: TextStyle(color: Colors.brown.shade900),
                      onChanged: (value) => _zenIDCard = value,
                      cursorColor: Colors.brown.shade900,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ZEN card number';
                        }
                        if (!RegExp(r'^[A-Z]{2}[0-9]{6}$').hasMatch(value)) {
                          return 'Verify your ZEN card number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    // Email Field
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.email, color: Colors.brown.shade700),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.brown.shade700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade900),
                        ),
                      ),
                      style: TextStyle(color: Colors.brown.shade900),
                      onChanged: (value) => _email = value,
                      cursorColor: Colors.brown.shade900,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    // Password Field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.brown.shade700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade900),
                        ),
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.brown.shade700),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.brown.shade700,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureText,
                      style: TextStyle(color: Colors.brown.shade900),
                      cursorColor: Colors.brown.shade900,
                      onChanged: (value) => _password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),

                    // Confirm Password Field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        labelStyle: TextStyle(color: Colors.brown.shade700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.brown.shade900),
                        ),
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.brown.shade700),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextt
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.brown.shade700,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextt = !_obscureTextt;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscureTextt,
                      style: TextStyle(color: Colors.brown.shade900),
                      cursorColor: Colors.brown.shade900,
                      onChanged: (value) => _confirmPassword = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.0),

                    // Sign-Up Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 120.0,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Merriweather',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _signUp();
                        }),
                    SizedBox(height: 30),

                    // Already have an account
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 16.0,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                  // Navigate to login page
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
