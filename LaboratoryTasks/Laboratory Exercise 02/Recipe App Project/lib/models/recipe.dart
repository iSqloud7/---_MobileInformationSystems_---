class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final List<Map<String, String>> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> j) {
    final List<Map<String, String>> ing = [];
    for (var i = 1; i <= 20; i++) {
      final ingKey = 'strIngredient$i';
      final measureKey = 'strMeasure$i';
      final ingVal = (j[ingKey] ?? '').toString().trim();
      final measVal = (j[measureKey] ?? '').toString().trim();
      if (ingVal.isNotEmpty) {
        ing.add({'ingredient': ingVal, 'measure': measVal});
      }
    }

    return Recipe(
      id: j['idMeal'] ?? '',
      name: j['strMeal'] ?? '',
      category: j['strCategory'] ?? '',
      area: j['strArea'] ?? '',
      instructions: j['strInstructions'] ?? '',
      thumbnail: j['strMealThumb'] ?? '',
      youtube: j['strYoutube'] ?? '',
      ingredients: ing,
    );
  }
}
