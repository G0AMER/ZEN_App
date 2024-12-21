import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

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
      home: WardrobeScreen(),
    );
  }
}

class WardrobeScreen extends StatefulWidget {
  @override
  _WardrobeScreenState createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  bool showAll = true;
  double imageSizeFactor = 0.2; // Adjustable size factor for images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Wardrobe',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBarSection(
            showAll: showAll,
            onTabChanged: (isAll) {
              setState(() {
                showAll = isAll;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: showAll ? allItems.length : boughtItems.length,
              itemBuilder: (context, index) {
                return showAll
                    ? allItems[index](imageSizeFactor)
                    : boughtItems[index](imageSizeFactor);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  final List<Widget Function(double)> allItems = [
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/sweatshirt.png',
      title: 'SWEAT SHIRT',
      price: '48.93 TND',
      reference: '39ZVSW54',
      rating: '4.8',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/jogger.png',
      title: 'PANTALON JOGGER',
      price: '41.93 TND',
      reference: '37EZFPNH',
      rating: '4.1',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/shoes.png',
      title: 'BASKET',
      price: '89.94 TND',
      reference: '37ZTSH03',
      rating: '5.0',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/tshirt.png',
      title: 'T-shirt',
      price: '35.95 TND',
      reference: '39ZTLH26',
      rating: '4.0',
      imageSizeFactor: imageSizeFactor,
    ),
  ];

  final List<Widget Function(double)> boughtItems = [
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/hat.png',
      title: 'HAT',
      price: '25.50 TND',
      reference: '39ZHT23',
      rating: '4.6',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/scarf.png',
      title: 'SCARF',
      price: '30.00 TND',
      reference: '39ZSC45',
      rating: '4.7',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/gloves.png',
      title: 'GLOVES',
      price: '18.90 TND',
      reference: '39ZGV89',
      rating: '4.5',
      imageSizeFactor: imageSizeFactor,
    ),
        (imageSizeFactor) => ProductCard(
      imageUrl: 'assets/jacket.png',
      title: 'JACKET',
      price: '120.00 TND',
      reference: '39ZJK12',
      rating: '4.9',
      imageSizeFactor: imageSizeFactor,
    ),
  ];
}

class TabBarSection extends StatelessWidget {
  final bool showAll;
  final Function(bool) onTabChanged;

  TabBarSection({required this.showAll, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onTabChanged(true),
            child: Text(
              'ALL',
              style: TextStyle(
                color: showAll ? Colors.black : Colors.grey,
                fontSize: 28,
                fontWeight: showAll ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 24),
          GestureDetector(
            onTap: () => onTabChanged(false),
            child: Text(
              'BOUGHT',
              style: TextStyle(
                color: !showAll ? Colors.black : Colors.grey,
                fontSize: 28,
                fontWeight: !showAll ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String reference;
  final String rating;
  final double imageSizeFactor;

  ProductCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.reference,
    required this.rating,
    required this.imageSizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: MediaQuery.of(context).size.width * imageSizeFactor,
              height: MediaQuery.of(context).size.width * imageSizeFactor,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(price, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Reference: $reference', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  Text('⭐ $rating Ratings', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text('Add Feedback'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: '',
        ),
      ],
    );
  }
}
