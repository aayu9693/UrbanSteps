import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/models/cart_model.dart';
import 'package:shoes_web/screens/booking_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.network(
                    item['image'] as String,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                  title: Text(item['name'] as String),
                  subtitle: Text('Size: ${item['size']}, Color: ${item['color']}'),
                  trailing: Text('\$${(item['price'] as num).toStringAsFixed(2)}'),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: cart.items.isEmpty ? null : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(products: cart.items),
                  ),
                );
              },
              child: Text('Proceed to Checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          );
        },
      ),
    );
  }
}

