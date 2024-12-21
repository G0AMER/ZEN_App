import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'log in.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Next Screen Placeholder')),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.jpg', // Ensure this image is in your assets folder
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // "BRANDS" centered
                      Text(
                        "BRANDS",
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF492B20),
                        ),
                      ),
                      SizedBox(height: 8),
                      // "AND NEW" with less indent than "BRANDS"
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 40.0), // Less indent
                        child: Text(
                          "AND NEW",
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF492B20),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // "STYLES" with less indent than "AND NEW"
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 100.0), // Less indent
                        child: Text(
                          "STYLES",
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF492B20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // The paragraph moved to the bottom
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      "Let's start to browse and\n"
                      " purchase the latest\n"
                      "fashion brands and styles",
                      style: TextStyle(
                        fontSize: 22, // Larger font size
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Keep the shape of the buttons the same
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return SignUpSheet();
                          },
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF492B20),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.7, // Increased initial size
        minChildSize: 0.6, // Adjusted min size
        maxChildSize: 1, // Adjusted max size
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'ZEN Card Number'),
                  ),
                  SizedBox(height: 20),
                  // "Sign Up" button in brown with white text and bigger size
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF492B20), // Brown color
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdScreen()),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white, // White text
                          fontSize: 20, // Larger text
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // "Or Continue With" section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Or Continue With",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  // Social Media Login Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SizedBox(
                          width:
                              24.0, // Set the width to match the typical icon size
                          height:
                              24.0, // Set the height to match the typical icon size
                          child: Image.asset(
                              'assets/apple_logo.png'), // Replace with your local image path
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SizedBox(
                          width:
                              24.0, // Set the width to match the typical icon size
                          height:
                              24.0, // Set the height to match the typical icon size
                          child: Image.asset(
                              'assets/facebook_logo.png'), // Replace with your local image path
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SizedBox(
                          width:
                              24.0, // Set the width to match the typical icon size
                          height:
                              24.0, // Set the height to match the typical icon size
                          child: Image.asset(
                              'assets/google_logo.png'), // Replace with your local image path
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Already have an account? Login text at the bottom
                  SizedBox(
                      height:
                          20), // Ensures space between social media icons and the button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThirdScreen()),
                        );
                      },
                      child: Text('Already have an account? Login'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Center(
        child: Text('Welcome to the third screen!'),
      ),
    );
  }
}
