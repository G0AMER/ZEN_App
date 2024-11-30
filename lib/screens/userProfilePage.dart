import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/login.dart';

class UserProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // Extract account name from email if displayName is null
    String accountName = user != null && user!.email != null
        ? user!.email!.split('@')[0]
        : 'Guest';

    return Scaffold(
      body: user != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile picture
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.brown.shade100,
                      backgroundImage: user!.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : AssetImage('assets/default_avatar.png')
                              as ImageProvider,
                    ),
                    SizedBox(height: 20),
                    // User name
                    Text(
                      user!.displayName ?? accountName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900,
                      ),
                    ),
                    SizedBox(height: 10),
                    // User email
                    Text(
                      user!.email ?? 'No Email Available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(color: Colors.grey.shade300),
                    // Additional Info Section
                    Text(
                      'Account Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade700,
                      ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.calendar_today,
                          color: Colors.brown.shade700),
                      title: Text('Created On'),
                      subtitle: Text(
                        user!.metadata.creationTime != null
                            ? user!.metadata.creationTime!.toLocal().toString()
                            : 'N/A',
                      ),
                    ),
                    SizedBox(height: 20),
                    // Log Out Button
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ); // Navigate back after sign-out
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                'No user is logged in!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
