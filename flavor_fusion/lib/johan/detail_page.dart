import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  Future<Map<String, dynamic>> _fetchRecipeDetails() async {
  const apiKey = 'fcb7962ac7b8416a87956fc90c3dc679';

  final response = await http.get(
    Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    // Obtengo la lista de ingredientes
    final List<dynamic> extendedIngredients = data['extendedIngredients'];

    // Mapeo la lista de ingredientes y extrae el nombre de cada ingrediente
    final List ingredients = extendedIngredients.map((ingredient) {
      return ingredient['original'];
    }).toList();

    return {
      'title': data['title'],
      'image': data['image'],
      'calories': data['calories'],
      'ingredients': ingredients,
      'instructions': data['instructions'],
      'servings': data['servings'],
      'readyInMinutes': data['readyInMinutes'],
      'summary': data['summary']
    };
  } else {
    throw Exception('Error al cargar los detalles de la receta');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la receta'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchRecipeDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final recipeDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(recipeDetails['image']),
                    const SizedBox(height: 20),
                    Text(
                      'Nombre: ${recipeDetails['title']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Descripcion:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                     Text(
                      '${recipeDetails['summary']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Rendira para: ${recipeDetails['servings']} personas',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tiempo preparacion: ${recipeDetails['readyInMinutes']} minutos',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Calorías: ${recipeDetails['calories']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ingredientes:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (recipeDetails['ingredients'] as List<dynamic>).map((ingredient) {
                        return Text('- $ingredient');
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Instrucciones de preparación:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${recipeDetails['instructions'] ?? "No hay instrucciones disponibles"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}