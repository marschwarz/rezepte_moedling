import 'dart:convert';

class Recipe {
  final String id;
  final String name;
  final String description;
  final String ingredients;
  final String imageURL;
  final double rating;

  Recipe(
      {required this.id,
      required this.name,
      required this.description,
      required this.ingredients,
      this.imageURL = "",
      required this.rating});

  @override
  String toString() {
    return 'Recipe{id=$id, name=$name, description=$description, ingredients=$ingredients, imageURL=$imageURL, rating=$rating}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageURL': imageURL,
      'rating': rating,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      ingredients: map['ingredients'] ?? '',
      imageURL: map['imageURL'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));
}
