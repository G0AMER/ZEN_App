import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: ProfileScreen1(),
    );
  }
}

class ProfileScreen1 extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen1> {
  final User? user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showImageOverlay(BuildContext context, String imagePath) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            // Full-screen background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Overlay content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile Photo and Name
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/user1.png'),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Kais Saadaoui",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Customized Like, Comment, and Share icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Like clicked');
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/like_icon.png',
                                // Custom Like icon
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Like',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Comment clicked');
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/comment_icon.png',
                                // Custom Comment icon
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Comment',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Share clicked');
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/share_icon.png',
                                // Custom Share icon
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Share',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String accountName = user != null && user!.email != null
        ? user!.email!.split('@')[0]
        : 'Guest';

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/user2.png"),
                      // Replace with your image path
                      fit: BoxFit.contain, // Ensures the whole image is visible
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text("4",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Publications",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text("1K",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Followers",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text("100",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Following",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print('Share clicked');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Share", style: TextStyle(fontSize: 14)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          print('Edit clicked');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Edit", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    user!.email ?? 'No Email Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Never Without Zen",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("ZEN's scoring points: 500",
                      style: TextStyle(fontSize: 14)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(10),
              children: List.generate(6, (index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      _showImageOverlay(
                          context, 'assets/images/post${index + 1}.png');
                    }
                  },
                  child: Image.asset('assets/images/post${index + 1}.png'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
