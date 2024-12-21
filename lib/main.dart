import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_fashion_app/firebase/login.dart';
import 'package:my_fashion_app/firebase/signup.dart';
import 'package:my_fashion_app/screens/loadingScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'ZEN App',
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _buttonOffsetAnimation;
  late Animation<Offset> _textOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _buttonOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));

    _textOffsetAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image 10.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0, left: 30.0),
                child: Text(
                  '\t\t\t\t\t\t\t\t\t\t\tBRANDS\n\t\t\t\t\t\t\t\tAND NEW\n\t\t\t\tSTYLES',
                  style: TextStyle(
                    color: Colors.black,
                    // Matching the font color in the image
                    fontSize: 40,
                    // Adjusted for exact size
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PlayfairDisplay',
                    // Elegant serif font
                    height: 1.2, // Line height for proper spacing
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0, left: 0.0),
                child: Text(
                  "Let's start to browse and purchase the latest \nfashion brands and styles.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                    // Subtle gray for description
                    fontSize: 25,
                    // Adjusted font size
                    fontFamily: 'Arial',
                    // Sans-serif for description
                    height: 1.5, // Proper spacing for readability
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SlideTransition(
                    position: _buttonOffsetAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        minimumSize: Size(300.0, 60.0),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SlideTransition(
                    position: _buttonOffsetAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.brown.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        minimumSize: Size(300.0, 60.0),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
