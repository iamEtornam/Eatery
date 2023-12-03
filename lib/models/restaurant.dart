import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class Restaurant {
  int? id;
  @JsonKey(name: 'user_id')
  String? userId;
  String? username;
  @JsonKey(name: 'restaurant_name')
  String? restaurantName;
  @JsonKey(name: 'restaurant_location')
  String? restaurantLocation;
  @JsonKey(name: 'restaurant_logo')
  String? restaurantLogo;
  @JsonKey(name: 'restaurant_lat')
  int? restaurantLat;
  @JsonKey(name: 'restaurant_lng')
  int? restaurantLng;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Restaurant({
    this.id,
    this.userId,
    this.username,
    this.restaurantName,
    this.restaurantLocation,
    this.restaurantLogo,
    this.restaurantLat,
    this.restaurantLng,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Restaurant(id: $id, userId: $userId, username: $username, restaurantName: $restaurantName, restaurantLocation: $restaurantLocation, restaurantLogo: $restaurantLogo, restaurantLat: $restaurantLat, restaurantLng: $restaurantLng, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return _$RestaurantFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  Restaurant copyWith({
    int? id,
    String? userId,
    String? username,
    String? restaurantName,
    String? restaurantLocation,
    String? restaurantLogo,
    int? restaurantLat,
    int? restaurantLng,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Restaurant(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantLocation: restaurantLocation ?? this.restaurantLocation,
      restaurantLogo: restaurantLogo ?? this.restaurantLogo,
      restaurantLat: restaurantLat ?? this.restaurantLat,
      restaurantLng: restaurantLng ?? this.restaurantLng,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
