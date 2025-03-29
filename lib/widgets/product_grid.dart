import 'package:flutter/material.dart';
import 'package:shoes_web/widgets/product_details_page.dart';

final List<Map<String, dynamic>> _products = [
  {'name': 'Classic Sneakers', 'price': 79.99, 'image': 'https://images.pexels.com/photos/13457488/pexels-photo-13457488.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
  {'name': 'Running Shoes', 'price': 99.99, 'image': 'https://images.pexels.com/photos/18202644/pexels-photo-18202644/free-photo-of-multi-colored-nike-trainers.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
  {'name': 'Casual Loafers', 'price': 69.99, 'image': 'https://images.pexels.com/photos/12031204/pexels-photo-12031204.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
  {'name': 'Hiking Boots', 'price': 129.99, 'image': 'https://images.pexels.com/photos/23319173/pexels-photo-23319173/free-photo-of-boots-of-sitting-man.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
  {'name': 'Dress Shoes', 'price': 89.99, 'image': 'https://images.pexels.com/photos/7862434/pexels-photo-7862434.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
  {'name': 'Sandals', 'price': 49.99, 'image': 'https://images.pexels.com/photos/27063085/pexels-photo-27063085/free-photo-of-woman-wearing-heels.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'},
];

class ProductGrid extends StatelessWidget {
  final bool shrinkWrap;

  ProductGrid({Key? key, this.shrinkWrap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(product: product),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    product['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(product['name']),
                      Text('\$${product['price'].toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

