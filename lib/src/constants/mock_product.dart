import 'package:campus_cravings/src/models/product/product.dart';

const Product kMockFeatured = Product(
  id: "0",
  name: 'Big Garden Salad',
  imageUrl: 'mock_product_1',
  price: 2.0,
  distance: 1.0,
);

const List<Product> mockProducts = [
  Product(
    id: "0",
    name: 'Big Garden Salad',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Salad'],
    price: 2.0,
  ),
  Product(
    id: "1",
    name: 'Double Hamburger',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Starters'],
    price: 3.0,
  ),
];