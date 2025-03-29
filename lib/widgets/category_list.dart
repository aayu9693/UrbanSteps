import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories = [
    'All',
    'Sport Shoes',
    'Sneakers',
    'Sandals',
    'Formal Shoes',
    'Slippers',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: index == 0, // You can implement actual selection logic
              onSelected: (selected) {
                // Implement category selection logic
              },
            ),
          );
        },
      ),
    );
  }
}