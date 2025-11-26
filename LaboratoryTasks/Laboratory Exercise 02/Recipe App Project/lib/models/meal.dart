class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory Meal.fromJson(Map<String, dynamic> j) => Meal(
    id: j['idMeal'] ?? '',
    name: j['strMeal'] ?? '',
    thumbnail: j['strMealThumb'] ?? '',
  );
}
