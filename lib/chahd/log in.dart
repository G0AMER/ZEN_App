import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _isCodeResent = false; // Flag for showing "Code Resent!" message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show the "Code Resent!" message at the top if flag is true
              if (_isCodeResent)
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "Code Resent!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // Login Heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome back! It's good to see you again",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Email TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    onPressed: () {
                      // Show Forgot Password Modal
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
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 50),
                                TextField(
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
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70), // Larger button
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
                ),
              ),
              SizedBox(height: 20),
              // Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF492B20),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60), // Smaller button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              // Remember Me Checkbox on the left
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    Text("Remember Me"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Or Continue With
              Text("Or continue with", style: TextStyle(color: Colors.grey[700])),
              SizedBox(height: 10),
              // Social Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/apple_logo.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/facebook_logo.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/google_logo.png'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: Text("Sign up"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Home Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF492B20),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60), // Smaller button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to show email verification modal
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
                "Please enter the 4-digit code sent to kais.saadaoui@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCodeBox(),
                  SizedBox(width: 10),
                  _buildCodeBox(),
                  SizedBox(width: 10),
                  _buildCodeBox(),
                  SizedBox(width: 10),
                  _buildCodeBox(),
                ],
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70), // Larger button
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

  // Function to show new password modal
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70), // Larger button
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

  // Helper method to create the code box
  Widget _buildCodeBox() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          "",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Text("Welcome to your Dashboard!"),
      ),
    );
  }
}


