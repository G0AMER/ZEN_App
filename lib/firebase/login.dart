import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_fashion_app/firebase/signup.dart';
import 'package:my_fashion_app/main.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../screens/webView.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _forgotPassEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isCodeResent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _forgotPassEmailController.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmailPassword() async {
    print(_emailController.text);
    print(1);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      _showSuccessDialog(userCredential.user?.email ?? 'Unknown User');
    } on FirebaseAuthException catch (e) {
      print(e);
      _showErrorSnackBar(e.message ?? 'An error occurred');
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        _showSuccessDialog(userCredential.user?.email ?? 'Google User');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to sign in with Google');
    }
  }

  Future<void> _loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      _showSuccessDialog(userCredential.user?.email ?? 'Apple User');
    } catch (e) {
      _showErrorSnackBar('Failed to sign in with Apple');
    }
  }

  void _showSuccessDialog(String userEmail) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ZenPage()));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('Welcome, $userEmail'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ZenPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/baniere-femme-1-.webp'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Adjust the opacity here
                  BlendMode.dstATop, // Blend mode to apply the transparency
                ),
              ),
            ),
          ),
          // Overlay and Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Welcome back! it’s good to see you again",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.0),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Password Field
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      //suffixText: 'Forgot Password?',
                      suffixStyle: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Show Forgot Password Modal
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height *
                                0.45, // Shortened height
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 50),
                                TextField(
                                  controller: _forgotPassEmailController,
                                  decoration: InputDecoration(
                                    labelText: "Enter your email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                                SizedBox(height: 50),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF492B20),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 70), // Larger button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showVerificationModal(context);
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                  SizedBox(height: 16.0),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      print(_passwordController.text);
                      _loginWithEmailPassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  // Remember Me Checkbox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),

                  // Social Media Login
                  Text(
                    "Or continue with",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _loginWithGoogle,
                        child: Image.asset(
                          'assets/google.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: _loginWithApple,
                        child: Image.asset(
                          'assets/apple.png',
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),

                  // Sign Up Prompt
                  RichText(
                    text: TextSpan(
                      text: "You don’t have an account? ",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.0),

                  // Home Button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    icon: Icon(Icons.home, color: Colors.white),
                    label: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showVerificationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.45, // Shortened height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Please enter the 4-digit code sent to " +
                    _forgotPassEmailController.text,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) => _buildCodeBox(index)),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // Resend Code logic
                  setState(() {
                    _isCodeResent = true;
                  });

                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      _isCodeResent = false;
                    });
                  });
                },
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF492B20),
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 70), // Larger button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showNewPasswordModal(context);
                },
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showNewPasswordModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.55, // Shortened height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create a New Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              // New Password Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: TextStyle(fontSize: 16)),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 20),
              // Confirm Password Field
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password", style: TextStyle(fontSize: 16)),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF492B20),
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 70), // Larger button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the modal
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  Widget _buildCodeBox(int index) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24, color: Colors.black),
        decoration: InputDecoration(
          counterText: '', // Removes the counter text
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < _focusNodes.length - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus(); // Dismisses the keyboard
            }
          }
        },
      ),
    );
  }
}
