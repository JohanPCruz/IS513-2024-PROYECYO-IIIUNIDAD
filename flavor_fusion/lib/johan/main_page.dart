import 'dart:convert';
import 'package:flavor_fusion/johan/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s='),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> meals = data['meals'];
      List<Map<String, dynamic>> recipes = [];
      if (meals != null) {
        for (var meal in meals) {
          final mealId = meal['idMeal'];
          final mealTitle = meal['strMeal'];
          final mealImage = meal['strMealThumb'];
          if (mealId != null && mealTitle != null && mealImage != null) {
            recipes.add({
              'id': mealId,
              'title': mealTitle,
              'image': mealImage,
            });
          }
        }
      }
      return recipes;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchRecipes(),
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
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(recipes[index]['title']),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(recipes[index]['image']),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(recipeId: recipes[index]['id']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}