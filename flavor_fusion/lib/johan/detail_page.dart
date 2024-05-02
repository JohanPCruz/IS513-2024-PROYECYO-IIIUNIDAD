import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({Key? key, required this.recipeId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchRecipeDetails() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      if (meals != null && meals.isNotEmpty) {
        final meal = meals[0];
        return {
          'title': meal['strMeal'],
          'image': meal['strMealThumb'],
          'instructions': await translateText(meal['strInstructions']),
          // Puedes agregar más detalles según lo necesites
        };
      } else {
        throw Exception('Recipe not found');
      }
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  Future<String> translateText(String text) async {
    final int maxQueryLength = 500;
    List<String> fragments = [];

    // Divide el texto en fragmentos más pequeños
    for (int i = 0; i < text.length; i += maxQueryLength) {
      fragments.add(text.substring(i, i + maxQueryLength < text.length ? i + maxQueryLength : text.length));
    }

    List<Future<String>> translationFutures = [];

    // Crea una lista de futuros de traducción
    for (String fragment in fragments) {
      translationFutures.add(_translateFragment(fragment));
    }

    // Espera a que todos los fragmentos se traduzcan y luego une los resultados
    List<String> translatedFragments = await Future.wait(translationFutures);
    return translatedFragments.join();
  }

  Future<String> _translateFragment(String fragment) async {
    final response = await http.get(
      Uri.parse('https://api.mymemory.translated.net/get?q=$fragment&langpair=en|es'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['responseData']['translatedText'];
    } else {
      throw Exception('Failed to translate text');
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
                      'Instrucciones:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${recipeDetails['instructions']}',
                      style: const TextStyle(fontSize: 18),
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

