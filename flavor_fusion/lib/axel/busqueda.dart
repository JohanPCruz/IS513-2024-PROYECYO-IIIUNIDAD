import 'dart:convert';
import 'package:flavor_fusion/johan/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecipeSearchScreen extends StatefulWidget {
  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  List<dynamic> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  Future<List<dynamic>> _searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['meals'];
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  void _onSearchTextChanged(String query) {
    _searchRecipes(query).then((results) {
      setState(() {
        _searchResults = results;
      });
    });
  }

  void _navigateToRecipeDetail(String recipeId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipeId: recipeId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar recetas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar receta',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final recipe = _searchResults[index];
                return ListTile(
                  title: Text(recipe['strMeal']),
                  leading: Image.network(recipe['strMealThumb']),
                  onTap: () {
                    _navigateToRecipeDetail(recipe['idMeal']);
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
