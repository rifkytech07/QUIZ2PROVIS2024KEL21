import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false, // Menghilangkan tombol panah kiri
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return FoodItem(index: index);
        },
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final int index;

  FoodItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailsScreen(index: index)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/makanan.jpg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text('Food Item ${index + 1}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class FoodDetailsScreen extends StatelessWidget {
  final int index;

  FoodDetailsScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
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
                Image.asset(
                  'assets/images/makanan.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text('Food Item ${index + 1}'),
                Text('Kumpulan Makanan'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).addItem('Food Item ${index + 1}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Food added to cart')),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
