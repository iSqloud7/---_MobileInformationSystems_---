import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';
import 'random_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  late Future<List<Category>> catsF;
  String query = '';

  @override
  void initState() {
    super.initState();
    catsF = api.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RandomScreen()),
            ),
            icon: const Icon(Icons.shuffle),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              style: const TextStyle(color: Colors.red),
              decoration: InputDecoration(
                hintText: 'Пребарувај категории',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[900],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Category>>(
        future: catsF,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Грешка: ${snapshot.error}'));
          final cats = snapshot.data!
              .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          if (cats.isEmpty) return const Center(child: Text('Нема категории'));
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: cats.length,
            itemBuilder: (context, i) {
              final c = cats[i];
              return CategoryCard(
                category: c,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealsScreen(category: c.name),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
