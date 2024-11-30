import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ZenPage extends StatelessWidget {
  // Method to launch URL in an external browser
  void _launchURL() async {
    Uri url = Uri.parse("https://hub.avaturn.me/create/scan");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/zen_logo.png',
          height: 120,
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
                    'Community',
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
                icon: Icon(Icons.style,
                    color: Colors.brown.shade700), // Wardrobe icon
                onPressed: () {
                  // Add wardrobe navigation here
                },
              ),
              IconButton(
                icon: Icon(Icons.qr_code_scanner,
                    color: Colors.brown.shade700), // Scanner icon
                onPressed: () {
                  // Add scanner navigation here
                },
              ),
              IconButton(
                icon:
                    Icon(Icons.home, color: Colors.brown.shade700), // Home icon
                onPressed: () {
                  // Add home navigation here
                },
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: Colors.brown.shade700), // Profile icon
                onPressed: () {
                  // Add profile navigation here
                },
              ),
              IconButton(
                icon: Icon(Icons.checkroom,
                    color: Colors.brown.shade700), // Hanger icon
                onPressed: () {
                  // Add hanger navigation here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
