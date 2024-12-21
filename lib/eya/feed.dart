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
      initialRoute: '/',
      routes: {
        '/': (context) => FeedScreen(),
      },
    );
  }
}

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

int _currentIndex = 2; // Default to Home page

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, String>> users = [
    {
      'name': 'Helmi Jerbi',
      'image': 'assets/images/user1.png',
      'photo': 'assets/images/photo1.png'
    },
    {
      'name': 'Karim Jmal',
      'image': 'assets/images/user2.png',
      'photo': 'assets/images/photo2.png'
    },
    {
      'name': 'Sami Haddi',
      'image': 'assets/images/user3.png',
      'photo': 'assets/images/photo3.png'
    },
    {
      'name': 'Sarah Aymen',
      'image': 'assets/images/user4.png',
      'photo': 'assets/images/photo4.png'
    },
    {
      'name': 'Mona Zied',
      'image': 'assets/images/user5.png',
      'photo': 'assets/images/photo5.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "ZEN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Top Horizontal Avatars with Circular Profile Photos
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the profile screen with user data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(user: users[index]),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(users[index]
                                  ['image']!), // Replace with your image path
                              fit: BoxFit
                                  .contain, // Ensures the whole image is visible
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          users[index]['name']!,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Feed Content (Posts)
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // Navigate to the profile screen with user data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(user: users[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(users[index][
                                          'image']!), // Replace with your image path
                                      fit: BoxFit
                                          .contain, // Ensures the whole image is visible
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10),
                            Text(
                              users[index]['name']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Post Image
                      Image.asset(
                        users[index]['photo']!,
                        fit: BoxFit.fill,
                      ),
                      // Actions Row
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {
                                    // Like button action
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.comment_outlined),
                                  onPressed: () {
                                    // Comment button action
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    // Share button action
                                  },
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Try button action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "TRY",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar (same as previous)
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
                  'assets/background.png', // Path to your image asset
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

class ProfileScreen extends StatelessWidget {
  final Map<String, String> user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${user['name']} Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(user['image']!),
            ),
            SizedBox(height: 20),
            Text(
              user['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("User Details and Posts go here."),
          ],
        ),
      ),
    );
  }
}
