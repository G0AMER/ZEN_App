import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

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
      home: CustomPhotoScreen(),
    );
  }
}

class CustomPhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Black Home Icon at Top Left
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
          ),

          // Buttons Centered Vertically and Horizontally
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // First Button: Choose Randomly
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VotingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Choose Randomly",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Second Button: With Friends
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VotingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "With Friends",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
}

class VotingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom Background Image
          Container(
            decoration: BoxDecoration(
                /*image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),*/
                ),
          ),

          // Functional Black Home Icon at Top Left
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomPhotoScreen()),
                      (route) => false,
                    );
                  },
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "VOTE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/user2.png', width: 100),
                          SizedBox(height: 10),
                          Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/vs.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/images/user1.png', width: 100),
                          SizedBox(height: 10),
                          Icon(Icons.favorite_border, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomBackgroundScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
}

class CustomBackgroundScreen extends StatefulWidget {
  @override
  _CustomBackgroundScreenState createState() => _CustomBackgroundScreenState();
}

class _CustomBackgroundScreenState extends State<CustomBackgroundScreen> {
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();

    // Delay the overlay appearance for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showOverlay = true;
      });
    });
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
                image: AssetImage('assets/images/custom_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Functional Black Home Icon at Top Left
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomPhotoScreen()),
                      (route) => false,
                    );
                  },
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),

          // Overlay (Appears after 3 seconds)
          if (_showOverlay)
            Container(
              color:
                  Colors.black.withOpacity(0.7), // Semi-transparent background
              child: Center(
                child: Text(
                  "Congratulations!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
