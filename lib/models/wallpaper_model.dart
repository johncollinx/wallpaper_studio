import 'package:flutter/foundation.dart';

class WallpaperModel {
  final String id; // unique identifier
  final String name;
  final String category;
  final String image;
  final List<String> tags; // for preview tags (Nature, Ambience, etc.)
  bool isFavourite;
  final String description; // for preview page

  WallpaperModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.tags = const [],
    this.isFavourite = false,
    this.description = '',
  });

  /// Toggles the favourite state
  void toggleFavourite() {
    isFavourite = !isFavourite;
  }

  /// Returns a copy with modified fields (useful for immutability and state mgmt)
  WallpaperModel copyWith({
    String? id,
    String? name,
    String? category,
    String? image,
    List<String>? tags,
    bool? isFavourite,
    String? description,
  }) {
    return WallpaperModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      image: image ?? this.image,
      tags: tags ?? this.tags,
      isFavourite: isFavourite ?? this.isFavourite,
      description: description ?? this.description,
    );
  }

  /// Convert model to map (for local storage or JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'tags': tags,
      'isFavourite': isFavourite,
      'description': description,
    };
  }

  /// Create model from map
  factory WallpaperModel.fromMap(Map<String, dynamic> map) {
    return WallpaperModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      isFavourite: map['isFavourite'] ?? false,
      description: map['description'] ?? '',
    );
  }

  @override
  String toString() =>
      'WallpaperModel(name: $name, category: $category, isFavourite: $isFavourite)';
}
