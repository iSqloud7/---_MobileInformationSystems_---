import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/recipe.dart';

class ApiService {
  static const _base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse('$_base/categories.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final list = (data['categories'] as List).cast<Map<String, dynamic>>();
      return list.map((e) => Category.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$_base/filter.php?c=${Uri.encodeComponent(category)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (data['meals'] == null) return [];
      final list = (data['meals'] as List).cast<Map<String, dynamic>>();
      return list.map((e) => Meal.fromJson(e)).toList();
    }
    throw Exception('Failed to load meals for category');
  }

  Future<List<Meal>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('$_base/search.php?s=${Uri.encodeComponent(query)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (data['meals'] == null) return [];
      final list = (data['meals'] as List).cast<Map<String, dynamic>>();
      return list.map((e) => Meal.fromJson(e)).toList();
    }
    throw Exception('Failed to search meals');
  }

  Future<Recipe> lookupMeal(String id) async {
    final res = await http.get(Uri.parse('$_base/lookup.php?i=${Uri.encodeComponent(id)}'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final item = (data['meals'] as List).first as Map<String, dynamic>;
      return Recipe.fromJson(item);
    }
    throw Exception('Failed to lookup meal');
  }

  Future<Recipe> randomMeal() async {
    final res = await http.get(Uri.parse('$_base/random.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final item = (data['meals'] as List).first as Map<String, dynamic>;
      return Recipe.fromJson(item);
    }
    throw Exception('Failed to fetch random meal');
  }
}