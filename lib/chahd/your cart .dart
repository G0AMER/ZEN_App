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
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = [
    {'id': 1, 'name': 'SWEAT SHIRT', 'price': 48.93, 'size': 'M', 'color': 'brown', 'quantity': 1, 'image': 'assets/sweatshirt.jpg'},
    {'id': 2, 'name': 'PANTALON JOGGER', 'price': 41.93, 'size': 'M', 'color': 'blue', 'quantity': 1, 'image': 'assets/pantalon_jogger.jpg'},
  ];

  void _removeItem(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _cartItems.removeWhere((item) => item['id'] == id);
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  void _increaseQuantity(int id) {
    setState(() {
      _cartItems.firstWhere((item) => item['id'] == id)['quantity']++;
    });
  }

  void _decreaseQuantity(int id) {
    setState(() {
      final item = _cartItems.firstWhere((item) => item['id'] == id);
      if (item['quantity'] > 1) {
        item['quantity']--;
      }
    });
  }

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Added successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double total = _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.brown),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Center( // Fully centered "Your Cart"
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*Image.asset(
                'assets/zen_logo.png',
                height: 40,
              ),*/
              const SizedBox(width: 10),
              Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey[300],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 130, // Larger image width
                            height: 130, // Larger image height
                            color: Colors.grey[300],
                            child: Image.asset(item['image'], fit: BoxFit.cover),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text('Size: ${item['size']}', style: TextStyle(fontSize: 14)),
                                Text('Color: ${item['color']}', style: TextStyle(fontSize: 14)),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => _decreaseQuantity(item['id']),
                                    ),
                                    Text('${item['quantity']}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () => _increaseQuantity(item['id']),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price', style: TextStyle(fontSize: 16)),
                                    Text(
                                      '${(item['price'] * item['quantity']).toStringAsFixed(2)} TND',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () => _removeItem(item['id']),
                                    child: Text('Remove', style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF7B1616), // Red color for the button
                                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '${total.toStringAsFixed(2)} TND',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _placeOrder,
              child: Text('Order', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF492B20),
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Welcome to the Home Screen!")),
    );
  }
}

