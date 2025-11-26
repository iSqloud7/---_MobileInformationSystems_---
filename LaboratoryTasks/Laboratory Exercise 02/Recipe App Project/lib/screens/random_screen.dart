import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  final ApiService api = ApiService();
  late Future<void> _fetchAndNavigate;

  @override
  void initState() {
    super.initState();
    _fetchAndNavigate = _go();
  }

  Future<void> _go() async {
    final recipe = await api.randomMeal();
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(mealId: recipe.id)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text('Рандом рецепт'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<void>(
        future: _fetchAndNavigate,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Грешка: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
