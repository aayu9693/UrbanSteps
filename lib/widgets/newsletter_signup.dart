import 'package:flutter/material.dart';

class NewsletterSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text(
            'Stay Updated',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Sign up for our newsletter to receive exclusive offers and the latest news',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement newsletter signup
                },
                child: Text('Subscribe'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

