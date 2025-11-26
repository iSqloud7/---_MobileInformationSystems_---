import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_tile.dart';
import 'detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;
  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService api = ApiService();
  late Future<List<Meal>> mealsF;
  String query = '';

  @override
  void initState() {
    super.initState();
    mealsF = api.fetchMealsByCategory(widget.category);
  }

  Future<void> performSearch(String q) async {
    setState(() => query = q);
    if (q.trim().isEmpty) {
      setState(() => mealsF = api.fetchMealsByCategory(widget.category));
    } else {
      final results = await api.searchMeals(q);
      setState(() => mealsF = Future.value(
          results.where((m) => m.name.toLowerCase().contains(q.toLowerCase())).toList()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (v) => performSearch(v),
              style: const TextStyle(color: Colors.red),
              decoration: InputDecoration(
                hintText: 'Пребарувај јадења',
                prefixIcon: const Icon(Icons.search, color: Colors.red),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey[900],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: mealsF,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return const Center(child: CircularProgressIndicator());
                if (snapshot.hasError)
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                final meals = snapshot.data!;
                if (meals.isEmpty) return const Center(child: Text('Нема јадења'));
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, i) {
                    final m = meals[i];
                    return MealTile(
                      meal: m,
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => DetailScreen(mealId: m.id))),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
