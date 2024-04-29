import 'dart:convert';
import 'package:flavor_fusion/johan/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    const apiKey = 'fcb7962ac7b8416a87956fc90c3dc679';
    const category = 'pizza'; 

    //https://api.spoonacular.com/recipes/informationBulk?&apiKey=efc260613de44dd7b58f7a0e37600e17&ids=715538,716429?
    //https://api.spoonacular.com/recipes/715538/information&apiKey=fcb7962ac7b8416a87956fc90c3dc679

    final response = await http.get(
      Uri.parse('https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$category'),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? data = json.decode(response.body)['results'];
      List<Map<String, dynamic>> recipes = [];
      if (data != null) {
        // ignore: avoid_function_literals_in_foreach_calls
        data.forEach((recipe) {
          final recipeTitle = recipe['title'];
          final recipeImage = recipe['image'];
          if (recipeTitle != null && recipeImage != null) {
            recipes.add({
              'title': recipeTitle,
              'image': recipeImage,
              'id': recipe['id'].toString(),
            });
          }
        });
      }
      return recipes;
    } else {
      throw Exception('Error al cargar las recetas');
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