import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/models/cart_model.dart';
import 'package:shoes_web/screens/cart_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedSize = 0;
  int _selectedColor = 0;
  int _quantity = 1;

  final List<String> _sizes = ['6', '7', '8', '9', '10', '11', '12'];
  final List<Color> _colors = [Colors.black, Colors.white, Colors.red, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.product['name']),
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        widget.product['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text('4.5 (250 reviews)'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(_sizes.length, (index) {
                      return ChoiceChip(
                        label: Text(_sizes[index]),
                        selected: _selectedSize == index,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSize = selected ? index : _selectedSize;
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Color',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(_colors.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = index;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _colors[index],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedColor == index ? Theme.of(context).primaryColor : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                      ),
                      Text('$_quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Product Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Experience unparalleled comfort and style with our premium ${widget.product['name']}. Crafted with the finest materials and cutting-edge technology, these shoes offer superior support and durability for all-day wear. The sleek design seamlessly blends fashion and function, making them perfect for both casual outings and athletic activities. Elevate your footwear game with this must-have addition to your collection.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final cart = Provider.of<CartModel>(context, listen: false);
                            cart.addItem({
                              ...widget.product,
                              'size': _sizes[_selectedSize],
                              'color': _colors[_selectedColor],
                              'quantity': _quantity,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to cart'),
                                action: SnackBarAction(
                                  label: 'View Cart',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CartPage()),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('Add to Cart'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final cart = Provider.of<CartModel>(context, listen: false);
                            cart.addItem({
                              ...widget.product,
                              'size': _sizes[_selectedSize],
                              'color': _colors[_selectedColor],
                              'quantity': _quantity,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartPage()),
                            );
                          },
                          child: Text('Buy Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

