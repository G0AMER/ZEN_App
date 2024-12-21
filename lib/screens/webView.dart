import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:my_fashion_app/eya/account.dart';
import 'package:my_fashion_app/eya/feed.dart';
import 'package:url_launcher/url_launcher.dart';

import '../eya/all.dart';
import '../eya/gaming.dart';
import '../eya/try code a barre.dart';

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
      home: ZenPage(),
    );
  }
}

class ZenPage extends StatefulWidget {
  @override
  _ZenPageState createState() => _ZenPageState();
}

void _launchURL() async {
  Uri url = Uri.parse("https://hub.avaturn.me/create/scan");
  await launchUrl(url);
}

int _currentIndex = 2; // Default to Home page

class _ZenPageState extends State<ZenPage> {
  // List of pages for navigation
  final List<Widget> _pages = [
    WardrobeApp(), // Replace with actual Wardrobe Page
    BarcodeScannerPage(), // Replace with actual Scanner Page
    HomePage(), // Replace with actual Home Page
    ProfileScreen1(), // User Profile Page
    Center(child: Text("Hanger Page")), // Replace with actual Hanger Page
  ];

  // Method to handle external URL launch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/zen_logo.png',
          height: 30,
        ),
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.grey.shade700),
          onPressed: () {
            // Add settings navigation here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.grey.shade700),
            onPressed: () {
              // Add cart navigation here
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/img.png', // Path to your image asset
                  height: 40, // Adjust size as needed
                  width: 40, // Adjust size as needed
                  color: Colors.brown.shade700,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0; // Navigate to Wardrobe page
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.qr_code_scanner, color: Colors.brown.shade700),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1; // Navigate to Scanner page
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.brown.shade700),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2; // Navigate to Home page
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.brown.shade700),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3; // Navigate to Profile page
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.checkroom, color: Colors.brown.shade700),
                onPressed: () {
                  setState(() {
                    _currentIndex = 4; // Navigate to Hanger page
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  void _showCommunityOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Community",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add navigation to Games page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomPhotoScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Increased roundness
                  ),
                  minimumSize:
                      Size(double.infinity, 50), // Full width and taller button
                ),
                child: Text(
                  'Games',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Add navigation to Feed page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Increased roundness
                  ),
                  minimumSize:
                      Size(double.infinity, 50), // Full width and taller button
                ),
                child: Text(
                  'Feed',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Text(
                  "Welcome to ZEN",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Explore and customize your avatar or connect with the community!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _launchURL,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Generate Avatar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add community navigation here
                    _showCommunityOptions(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                  ),
                  child: Text(
                    '   Community   ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
