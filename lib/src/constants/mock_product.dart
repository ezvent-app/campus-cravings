import 'package:campuscravings/src/models/product/product.dart';

const Product kMockFeatured = Product(
  id: "0",
  name: 'Big Garden Salad',
  imageUrl: 'mock_product_1',
  price: 10.0,
  distance: 1.0,
);

const List<Product> mockProducts = [
  Product(
    id: "0",
    name: 'Big Garden Salad',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Starters'],
    price: 2.0,
  ),
  Product(
    id: "1",
    name: 'Double Hamburger',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Coffee'],
    price: 3.0,
  ),
  Product(
    id: "2",
    name: 'Double Hamburger',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Salad'],
    price: 3.0,
  ),
  Product(
    id: "3",
    name: 'Double Hamburger',
    imageUrl: 'mock_product_1',
    categories: ['recommended', 'Drinks'],
    price: 3.0,
  ),
];
