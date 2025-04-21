// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      price: (json['price'] as num).toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'categories': instance.categories,
      'price': instance.price,
      'distance': instance.distance,
    };
