import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_application_kuis2/food.dart';
import 'package:flutter_application_kuis2/cart.dart';

class OrderStatusScreen extends StatefulWidget {
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  String _status = 'Order Accepted';
  late Timer _timer;

  void _refreshStatus(Timer timer) {
    setState(() {
      if (_status == 'Order Accepted') {
        _status = 'Driver Takes Your Order';
      } else if (_status == 'Driver Takes Your Order') {
        _status = 'Order Delivered';
      } else if (_status == 'Order Delivered') {
        _status = 'Order Arrived';
      } 
    });
  }

  IconData _getStatusIcon() {
    switch (_status) {
      case 'Order Accepted':
        return Icons.restaurant_menu;
      case 'Driver Takes Your Order':
        return Icons.motorcycle;
      case 'Order Delivered':
        return Icons.motorcycle;
      default:
        return Icons.check;
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), _refreshStatus);
  }

  @override
  void dispose() {
    _timer.cancel(); // Memastikan timer dihentikan ketika widget di dispose
    super.dispose();
  }

  void _completeOrder(BuildContext context) {
    // Kosongkan cart
    Provider.of<Cart>(context, listen: false).clearCart();
    // Arahkan kembali ke FoodListScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => FoodListScreen()),
      ModalRoute.withName('/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getStatusIcon(), size: 50),
            SizedBox(height: 20),
            Text('Status: $_status'),
            SizedBox(height: 20),
            if (_status == 'Order Arrived')
              ElevatedButton(
                onPressed: () => _completeOrder(context),
                child: Text('Complete'),
              ),
          ],
        ),
      ),
    );
  }
}
