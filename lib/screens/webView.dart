import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class WebViewExample extends StatelessWidget {
  // Method to launch URL in external browser
  void _launchURL() async {
    Uri url = Uri.parse("https://metaperson.avatarsdk.com/");
    await launchUrl(url);
    /*if (await canLaunchUrl(url)) {
      await launchUrl(url); // Launch the URL in the default browser
    } else {
      throw 'Could not launch $url'; // Handle error if URL can't be opened
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL, // Call _launchURL on button press
          child: const Text('Generate Avatar'),
        ),
      ),
    );
  }
}
