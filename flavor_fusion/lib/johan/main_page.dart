import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart'; // Importa la pantalla de detalle

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    const apiKey = 'fcb7962ac7b8416a87956fc90c3dc679';
    const category = 'recipes';
    //const number = 20;

    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$category'),
      //Uri.parse('https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$number'),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? data = json.decode(response.body)['results'];
      List<Map<String, dynamic>> recipes = [];
      if (data != null) {
        for (var recipe in data) {
          final recipeTitle = recipe['title'];
          final recipeImage = recipe['image'];
          if (recipeTitle != null && recipeImage != null) {
            recipes.add({
              'title': recipeTitle,
              'image': recipeImage,
              'id': recipe['id'].toString(),
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
            final recipes = snapshot.data;
            return ListView.builder(
              itemCount: recipes?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(recipes![index]['title']),
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
