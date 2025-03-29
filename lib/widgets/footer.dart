import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Us', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Our Story', style: TextStyle(color: Colors.white70)),
                  Text('Careers', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Service', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Contact Us', style: TextStyle(color: Colors.white70)),
                  Text('FAQs', style: TextStyle(color: Colors.white70)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Follow Us', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white), onPressed: () {}),
                      IconButton(icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.white), onPressed: () {}),
                      IconButton(icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('© 2023 UrbanSteps. All rights reserved.', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

