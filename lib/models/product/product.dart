import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String imageUrl,
    List<String>? categories,
    required double price,
    double? distance,
  }) = _Product;



  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}