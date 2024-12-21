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
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      home: WardrobeScreen(),
    );
  }
}

class WardrobeScreen extends StatefulWidget {
  @override
  _WardrobeScreenState createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  String selectedCategory = "Lightning";
  bool _isOverlayVisible = false; // To control overlay visibility

  // Map of categories and their items
  final Map<String, List<String>> categoryItems = {
    "Lightning": ["Lamp 1", "Lamp 2", "Lamp 3", "Lamp 4"],
    "Shirts": ["Shirt 1", "Shirt 2", "Shirt 3", "Shirt 4"],
    "Pants": ["Pant 1", "Pant 2", "Pant 3", "Pant 4"],
    "Dresses": ["Dress 1", "Dress 2", "Dress 3", "Dress 4"],
    "Bags": ["Bag 1", "Bag 2", "Bag 3", "Bag 4"],
    "Shoes": ["Shoe 1", "Shoe 2", "Shoe 3", "Shoe 4"],
  };

  // Map of categories and their corresponding image paths
  final Map<String, String> categoryImages = {
    "Lightning": "assets/images/lightning.jpg",
    "Shirts": "assets/images/shirts.jpg",
    "Pants": "assets/images/pants.jpg",
    "Dresses": "assets/images/dresses.jpg",
    "Bags": "assets/images/bags.jpg",
    "Shoes": "assets/images/shoes.jpg",
  };

  // Function to build category icons with photos
  Widget _buildCategoryPhoto(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Fallback to a default placeholder if the image fails to load
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedCategory == label ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Toggle visibility of the Status overlay
  void _toggleStatusOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.refresh, color: Colors.brown),
          onPressed: () {
            // Add functionality here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.brown),
            onPressed: () {
              // Add functionality here
            },
          ),
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: _toggleStatusOverlay, // Show overlay on tap
            child: Text(
              "Status", // The word "Status" is clickable
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main Content of the WardrobeScreen
          Column(
            children: [
              // Avatar Section
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.person, size: 100, color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Categories Section
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoryImages.entries.map((entry) {
                      return _buildCategoryPhoto(entry.value, entry.key);
                    }).toList(),
                  ),
                ),
              ),

              // Items Section
              Expanded(
                flex: 4,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.all(10),
                  children: categoryItems[selectedCategory]!
                      .map((item) => GestureDetector(
                    onTap: () {
                      // Add functionality for item selection
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(item),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),

          // Overlay to show in the middle and extend across the bottom
          if (_isOverlayVisible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // Position at the bottom of the screen
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width, // Full width
                  height: MediaQuery.of(context).size.height * 0.6, // 60% height from the bottom
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: StatusSharingScreen(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class StatusSharingScreen extends StatelessWidget {
  final List<Map<String, String>> friends = [
    {'name': 'Karim', 'image': 'assets/images/friend1.png'},
    {'name': 'Oussema', 'image': 'assets/images/friend2.png'},
    {'name': 'Eya', 'image': 'assets/images/friend3.png'},
    {'name': 'Helmi', 'image': 'assets/images/friend4.png'},
  ];

  Widget _buildFriendAvatar(String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 5),
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),

        // Profile Section
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        SizedBox(height: 10),
        Text(
          "Kais Saadaoui",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 10),

        // Status Comment Input
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Say something about this...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        SizedBox(height: 20),

        // Share Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildShareIcon("assets/images/zen.png", "Zen Chat"),
            SizedBox(width: 20),
            _buildShareIcon("assets/images/facebook.png", "Facebook"),
            SizedBox(width: 20),
            _buildShareIcon("assets/images/instagram.png", "Instagram"),
          ],
        ),

        SizedBox(height: 20),

        // Zen Chat Button
        ElevatedButton(
          onPressed: () {
            // Add functionality here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: Text("Share it on ZEN CHAT"),
        ),

        SizedBox(height: 20),

        // Friends Section
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: friends.map((friend) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _buildFriendAvatar(friend['name']!, friend['image']!),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShareIcon(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        // Share functionality
      },
      child: Column(
        children: [
          Image.asset(imagePath, width: 50, height: 50),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
