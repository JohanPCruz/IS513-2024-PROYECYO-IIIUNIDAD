import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({Key? key, required this.recipeId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchRecipeDetails() async {
    // Simulando datos de la receta
    return {
      'title': 'Sopa de Lentejas Rojas con Pollo y Nabos',
      'image': 'https://img.spoonacular.com/recipes/715415-312x231.jpg',
      'calories': 350,
      'ingredients': [
        '1 taza de lentejas rojas',
        '2 pechugas de pollo',
        '2 nabos',
        'Sal y pimienta al gusto',
      ],
      'instructions': '1. Hierva las lentejas en agua. 2. Agregue el pollo y los nabos picados. 3. Sazone con sal y pimienta. 4. Cocine hasta que el pollo esté listo.',
      'servings': 4,
      'readyInMinutes': 30,
      'summary': 'Esta deliciosa sopa es abundante y saludable, perfecta para una noche acogedora.'
    };
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
                      'Descripción:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                     Text(
                      '${recipeDetails['summary']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Rendimiento: ${recipeDetails['servings']} porciones',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tiempo de preparación: ${recipeDetails['readyInMinutes']} minutos',
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
