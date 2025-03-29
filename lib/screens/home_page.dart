import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_web/models/user_model.dart';
import 'package:shoes_web/models/cart_model.dart';
import 'package:shoes_web/widgets/category_list.dart';
import 'package:shoes_web/widgets/product_grid.dart';
import 'package:shoes_web/screens/cart_page.dart';
import 'package:shoes_web/screens/profile_page.dart';
import 'package:shoes_web/widgets/animated_background.dart';
import 'package:shoes_web/widgets/featured_products_carousel.dart';
import 'package:shoes_web/widgets/trending_brands.dart';
import 'package:shoes_web/widgets/newsletter_signup.dart';
import 'package:shoes_web/widgets/footer.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showBackToTopButton = _scrollController.offset >= 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'UrbanSteps',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                if (cart.itemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
              radius: 15,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedBackground(),
          SizedBox.expand(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Animate(
                      effects: [
                        ScaleEffect(
                          begin: Offset(1, 1),
                          end: Offset(1.1, 1.1),
                          duration: 2000.ms,
                          curve: Curves.easeInOut,
                        ),
                      ],
                      child: Text(
                        'Step into Style',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for shoes...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Icon(Icons.filter_list, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        // Implement search functionality
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CategoryList(),
                  SizedBox(height: 20),
                  FeaturedProductsCarousel(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Trending Now',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ProductGrid(shrinkWrap: true),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: TrendingBrands(),
                  ),
                  SizedBox(height: 20),
                  NewsletterSignup(),
                  SizedBox(height: 20),
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        child: Icon(Icons.arrow_upward),
        backgroundColor: Theme.of(context).primaryColor,
      )
          : null,
    );
  }
}

