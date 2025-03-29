class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

// Example product data
List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Nike Air Max',
    description: 'Comfortable running shoes with air cushioning.',
    price: 129.99,
    imageUrl: 'https://example.com/nike-air-max.jpg',
    category: 'Sport Shoes',
  ),
  Product(
    id: '2',
    name: 'Adidas Superstar',
    description: 'Classic sneakers with iconic shell toe.',
    price: 89.99,
    imageUrl: 'https://example.com/adidas-superstar.jpg',
    category: 'Sneakers',
  ),
  Product(
    id: '3',
    name: 'Birkenstock Arizona',
    description: 'Comfortable sandals with adjustable straps.',
    price: 99.99,
    imageUrl: 'https://example.com/birkenstock-arizona.jpg',
    category: 'Sandals',
  ),
  // Add more products as needed
];