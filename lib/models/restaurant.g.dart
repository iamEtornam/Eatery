// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      restaurantName: json['restaurant_name'] as String?,
      restaurantLocation: json['restaurant_location'] as String?,
      restaurantLogo: json['restaurant_logo'] as String?,
      restaurantLat: json['restaurant_lat'] as int?,
      restaurantLng: json['restaurant_lng'] as int?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'username': instance.username,
      'restaurant_name': instance.restaurantName,
      'restaurant_location': instance.restaurantLocation,
      'restaurant_logo': instance.restaurantLogo,
      'restaurant_lat': instance.restaurantLat,
      'restaurant_lng': instance.restaurantLng,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
