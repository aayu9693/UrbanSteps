import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const BookingPage({Key? key, required this.products}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Purchase'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...widget.products.map((product) => Card(
                margin: EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(product['name'] as String),
                  subtitle: Text('Size: ${product['size']}, Color: ${product['color']}'),
                  trailing: Text('\$${(product['price'] as num).toStringAsFixed(2)}'),
                ),
              )),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Shipping Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                onSaved: (value) => _address = value!,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the order
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
      // Navigate back to home or order confirmation page
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }
}

