import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const WardrobeApp(),
    ),
  );
}

class WardrobeApp extends StatefulWidget {
  const WardrobeApp({Key? key}) : super(key: key);

  @override
  _WardrobeAppState createState() => _WardrobeAppState();
}

class _WardrobeAppState extends State<WardrobeApp> {
  int _currentIndex = 0; // Current selected page index

  final List<Widget> _pages = [
    const WardrobeScreen(),
    const ShopScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentIndex],
      ),
    );
  }
}

// Wardrobe Screen
class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  _WardrobeScreenState createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  final List<Map<String, dynamic>> allItems = [
    {
      'title': 'Sweat Shirt',
      'image': 'assets/sweatshirt.jpg',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'Pantalon Jogger',
      'image': 'assets/pantalon.jpg',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'Cap',
      'image': 'assets/cap.jpg',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'Basket',
      'image': 'assets/basket.png',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'T-shirt',
      'image': 'assets/tshirst.jpg',
      'isFavorite': false,
      'inCart': false
    },
  ];

  final List<Map<String, dynamic>> boughtItems = [
    {
      'title': 'Sweat Shirt',
      'image': 'assets/sweatshirt.jpg',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'Pantalon Jogger',
      'image': 'assets/pantalon.jpg',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'Basket',
      'image': 'assets/basket.png',
      'isFavorite': false,
      'inCart': false
    },
    {
      'title': 'T-shirt',
      'image': 'assets/tshirst.jpg',
      'isFavorite': false,
      'inCart': false
    },
  ];

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      item['isFavorite'] = !item['isFavorite'];
    });
  }

  void toggleCart(Map<String, dynamic> item) {
    setState(() {
      item['inCart'] = !item['inCart'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wardrobe',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('ALL',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      return ItemCard(
                        item: item,
                        onFavoritePressed: () => toggleFavorite(item),
                        onCartPressed: () => toggleCart(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to new interface when BOUGHT is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BoughtItemsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'BOUGHT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red), // Make BOUGHT tappable and styled
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: boughtItems.length,
                    itemBuilder: (context, index) {
                      final item = boughtItems[index];
                      return ItemCard(
                        item: item,
                        onFavoritePressed: () => toggleFavorite(item),
                        onCartPressed: () => toggleCart(item),
                      );
                    },
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

// New Screen for BOUGHT Interface
class BoughtItemsScreen extends StatelessWidget {
  const BoughtItemsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> boughtItems = const [
    {
      'title': 'SWEAT SHIRT',
      'price': '49.95 TND',
      'reference': '387XWS4',
      'size': 'L',
      'image': 'assets/sweatshirt.jpg'
    },
    {
      'title': 'PANTALON JOGGER',
      'price': '41.95 TND',
      'reference': '372ZPFN4',
      'size': 'M',
      'image': 'assets/pantalon.jpg'
    },
    {
      'title': 'BASKET',
      'price': '89.94 TND',
      'reference': '387ZFH03',
      'size': '42',
      'image': 'assets/basket.png'
    },
    {
      'title': 'T-shirt',
      'price': '32.95 TND',
      'reference': '387XLQ8',
      'size': 'S',
      'image': 'assets/tshirst.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wardrobe - Bought',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: boughtItems.length,
        itemBuilder: (context, index) {
          final item = boughtItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(item['image'], width: 60, fit: BoxFit.cover),
              title: Text(item['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${item['price']}'),
                  Text('Reference: ${item['reference']}'),
                  Text('Size: ${item['size']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onCartPressed;

  const ItemCard({
    Key? key,
    required this.item,
    this.onFavoritePressed,
    this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(item['image'], width: 100, height: 100, fit: BoxFit.cover),
        const SizedBox(height: 8),
        Text(
          item['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                item['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                color: item['isFavorite'] ? Colors.red : null,
              ),
              onPressed: onFavoritePressed,
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: item['inCart'] ? Colors.green : null),
              onPressed: onCartPressed,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

// Add empty constructors for ShopScreen and ProfileScreen
class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Shop Screen')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Profile Screen')),
    );
  }
}
