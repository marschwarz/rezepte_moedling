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
      this.imageURL = 'https://via.placeholder.com/150',
      required this.rating});
}
