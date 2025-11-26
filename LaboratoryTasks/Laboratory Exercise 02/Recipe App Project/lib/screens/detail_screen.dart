import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/recipe.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;
  const DetailScreen({super.key, required this.mealId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService api = ApiService();
  late Future<Recipe> recipeF;

  @override
  void initState() {
    super.initState();
    recipeF = api.lookupMeal(widget.mealId);
  }

  Future<void> _openYoutube(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепт'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Recipe>(
        future: recipeF,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Грешка: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
          }

          final r = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (r.thumbnail.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.network(
                      r.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 128, color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  r.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 6),
                Text(
                  'Категорија: ${r.category} • Област: ${r.area}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Составки',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 6),
                ...r.ingredients.map(
                      (ing) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('- ${ing['ingredient']} — ${ing['measure']}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Упатства',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 6),
                Text(
                  r.instructions,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                if (r.youtube.isNotEmpty)
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _openYoutube(r.youtube),
                      icon: const Icon(Icons.youtube_searched_for),
                      label: const Text('Отвори YouTube'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
