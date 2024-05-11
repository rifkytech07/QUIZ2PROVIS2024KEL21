import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_kuis2/food.dart';
import 'package:flutter_application_kuis2/cart.dart'; // Import CheckoutScreen from checkout.dart
import 'package:flutter_application_kuis2/order_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Authentication()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        title: 'Local Food Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        routes: {
          '/': (context) => HomeScreen(),
          '/login': (context) => HomeScreen(),
          '/foodlist': (context) => FoodListScreen(),
        },
      ),
    );
  }
}

class Authentication extends ChangeNotifier {
  bool isAuthenticated = false;

  void login() {
    isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    isAuthenticated = false;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kelompok 21: Muhammad Rifky Afandi & Indra Aldi'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    auth.login();
                    Navigator.pushNamed(context, '/foodlist');
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
