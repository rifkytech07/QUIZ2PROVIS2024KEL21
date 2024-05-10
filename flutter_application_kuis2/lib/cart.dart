import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_kuis2/order_status.dart';

class Cart with ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  void addItem(String itemName) {
    if (_items.containsKey(itemName)) {
      _items[itemName] = _items[itemName]! + 1;
    } else {
      _items[itemName] = 1;
    }
    notifyListeners();
  }

  void removeItem(String itemName) {
    if (_items.containsKey(itemName)) {
      if (_items[itemName] == 1) {
        _items.remove(itemName);
      } else {
        _items[itemName] = _items[itemName]! - 1;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value * 20; // Assuming each item costs $20
    });
    return total;
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cart Items'),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final foodName = cart.items.keys.toList()[index];
                      final quantity = cart.items.values.toList()[index];
                      return ListTile(
                        title: Text(foodName),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Quantity: $quantity'),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cart.removeItem(foodName);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Konfirmasi Pembayaran"),
                          content: Text("Apakah Yakin Bayar Sekarang?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Tidak",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OrderStatusScreen()),
                                );
                              },
                              child: Text(
                                "Ya",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Bayar Sekarang'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
