import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => OutfitApp(),
    ),
  );
}

class OutfitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outfit App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OutfitScreen(),
      routes: {
        '/cart': (context) => CartScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class OutfitScreen extends StatefulWidget {
  @override
  _OutfitScreenState createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
  String selectedCategory = 'shirts';
  bool showNotifications = false;

  final Map<String, List<String>> clothes = {
    'shirts': List.generate(6, (index) => 'Shirt ${index + 1}'),
    'pants': List.generate(6, (index) => 'Pants ${index + 1}'),
    'shoes': List.generate(6, (index) => 'Shoes ${index + 1}'),
  };

  final Map<String, List<String>> itemSizes = {
    'Shirt 1': ['XS', 'M', 'L'],
    'Shirt 2': ['L', 'XL'],
    'Shirt 3': ['M', 'L', 'XL', 'XXL'],
    // Add more items here as needed
  };

  void showNotification(String message) {
    setState(() {
      showNotifications = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showShareModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ShareModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (showNotifications) Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Message goes here!',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.grey[300],
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                categoryIcon('assets/icons/lightning.png', 'shirts'),
                categoryIcon('assets/icons/hanger.png', 'pants'),
                categoryIcon('assets/icons/shirt.png', 'dresses'),
                categoryIcon('assets/icons/pants.png', 'shoes'),
                categoryIcon('assets/icons/shoes.png', 'bags'),
                categoryIcon('assets/icons/coat.png', 'suits'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                itemCount: clothes[selectedCategory]?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsScreen(
                            itemName: clothes[selectedCategory]![index],
                            itemReference: 'REF1234',
                            itemRating: 4.5,
                            itemImage: 'assets/sample.png',
                            itemPrice: 99.99,
                            itemSizes: itemSizes[clothes[selectedCategory]![index]] ?? [],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Icon(Icons.image, size: 40),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: GestureDetector(
                            onTap: () => showNotification(
                                '${clothes[selectedCategory]![index]} is now on the avatar!'),
                            child: Icon(Icons.checkroom, color: Colors.grey[800]),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () =>
                                showNotification('Added to your cart!'),
                            child: Icon(Icons.add, color: Colors.blue[800]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            child: ElevatedButton(
              onPressed: () {
                showNotification('Loading more items...');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'More',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.replay),
          onPressed: () => showNotification('Outfit reset to initial state!'),
          tooltip: 'Reset Outfit',
        ),
        title: Row(
          children: [
            ElevatedButton(
              onPressed: showShareModal,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown),
              child: Text('Status', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
    );
  }

  Widget categoryIcon(String imagePath, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
    );
  }
}

class ItemDetailsScreen extends StatefulWidget {
  final String itemName;
  final String itemReference;
  final double itemRating;
  final String itemImage;
  final double itemPrice;
  final List<String> itemSizes;

  ItemDetailsScreen({
    required this.itemName,
    required this.itemReference,
    required this.itemRating,
    required this.itemImage,
    required this.itemPrice,
    required this.itemSizes,
  });

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  widget.itemImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(widget.itemName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Reference: ${widget.itemReference}'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text('${widget.itemRating}'),
              ],
            ),
            SizedBox(height: 16),
            Text('Available Sizes:'),
            SizedBox(height: 8),
            Row(
              children: widget.itemSizes.map((size) {
                bool isSelected = size == selectedSize;
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: isSelected ? Colors.blue : Colors.grey,
                      child: Text(
                        size,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price:', style: TextStyle(fontSize: 18)),
                Text('${widget.itemPrice.toStringAsFixed(2)} TND',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Buy Now', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareModal extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              SizedBox(width: 10),
              Text(
                'User Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: 'Write something here...'),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Shared successfully!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              child: Text('Share Now', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon1.png', width: 50, height: 50),
              SizedBox(width: 30),
              Image.asset('assets/icon2.png', width: 50, height: 50),
              SizedBox(width: 30),
              Image.asset('assets/icon3.png', width: 50, height: 50),
            ],
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Center(child: Text('Your cart is empty!')),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Home Screen')),
    );
  }
}
