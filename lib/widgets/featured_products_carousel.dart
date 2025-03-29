import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeaturedProductsCarousel extends StatelessWidget {
  final List<Map<String, String>> featuredProducts = [
    {'image': 'https://images.pexels.com/photos/12725052/pexels-photo-12725052.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'title': 'Air Jordan'},
    {'image': 'https://static01.nyt.com/images/2018/07/26/style/26SNEAKERS1/26SNEAKERS1-superJumbo-v3.jpg', 'title': 'Balenciaga'},
    {'image': 'https://www.ft.com/__origami/service/image/v2/images/raw/https:%2F%2Fs3-eu-west-1.amazonaws.com%2Fhtsi-ez-prod%2Fez%2Fimages%2F3%2F2%2F8%2F0%2F1360823-1-eng-GB%2F01-CINDERELLA-3.jpg?height=700&format=jpg&dpr=2&source=htsi', 'title': 'Jimmy Choo'},
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: featuredProducts.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['title']!,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

