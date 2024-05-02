import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_page.dart'; // Importa la pantalla de detalle

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  List<Map<String, dynamic>> _getRecipes() {
    return [
      {
        "id": 715415,
        "title": "Sopa de Lentejas Rojas con Pollo y Nabos",
        "image": "https://img.spoonacular.com/recipes/715415-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 716406,
        "title": "Sopa de Espárragos y Guisantes: Comida Real Conveniente",
        "image": "https://img.spoonacular.com/recipes/716406-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 644387,
        "title": "Col Rizada con Ajo",
        "image": "https://img.spoonacular.com/recipes/644387-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 715446,
        "title": "Estofado de Ternera en Olla de Cocción Lenta",
        "image": "https://img.spoonacular.com/recipes/715446-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 782601,
        "title": "Jambalaya de Frijoles Rojos",
        "image": "https://img.spoonacular.com/recipes/782601-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 716426,
        "title": "Coliflor, Arroz Integral y Arroz Frito de Verduras",
        "image": "https://img.spoonacular.com/recipes/716426-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 716004,
        "title": "Ensalada de Quinoa y Garbanzos con Tomates Secos y Cerezas Secas",
        "image": "https://img.spoonacular.com/recipes/716004-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 716627,
        "title": "Arroz y Frijoles Caseros Fáciles",
        "image": "https://img.spoonacular.com/recipes/716627-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 664147,
        "title": "Sopa Toscana de Frijoles Blancos con Aceite de Oliva y Romero",
        "image": "https://img.spoonacular.com/recipes/664147-312x231.jpg",
        "imageType": "jpg"
      },
      {
        "id": 640941,
        "title": "Guarnición Crujiente de Coles de Bruselas",
        "image": "https://img.spoonacular.com/recipes/640941-312x231.jpg",
        "imageType": "jpg"
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recipes = _getRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: ListView.builder(
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
                  builder: (context) => RecipeDetailScreen(recipeId: recipes[index]['id'].toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
