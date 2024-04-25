import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> fetchIngredients({
    required String sortDirection,
    required String sort,
    required String query,
    required int offset,
    required int number,
    required String intolerances,
  }) async {
    var url = Uri.parse('https://api.apilayer.com/spoonacular/food/ingredients/search');
    var queryParams = {
      'sortDirection': sortDirection,
      'sort': sort,
      'query': query,
      'offset': offset.toString(),
      'number': number.toString(),
      'intolerances': intolerances,
      'apikey': 'vHwuVEqAGqUnErEHjK1XZ1iuFMujZU8w',
    };

    var uri = Uri(queryParameters: queryParams).resolve(url as String);

    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<void> submitRecipe({
    required String apiKey,
    required String title,
    required String ingredients,
    required String instructions,
    required int cookingTime,
  }) async {
    var url = Uri.parse('https://api.spoonacular.com/recipes');
    var headers = {'apikey': apiKey};
    var recipeData = {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
      'cookingTime': cookingTime,
    };

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(recipeData),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      } else {
        print('Error al enviar la receta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<List<String>> fetchIngredientSuggestions(String query) async {
    var url = Uri.parse('https://api.spoonacular.com/recipes/autocomplete');
    var queryParams = {
      'query': query,
      'number': '5', 
      'apiKey': 'vHwuVEqAGqUnErEHjK1XZ1iuFMujZU8w',
    };

    var uri = Uri(queryParameters: queryParams).resolve(url as String);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<String> suggestions = [];
        for (var data in responseData) {
          suggestions.add(data['title']);
        }
        return suggestions;
      } else {
        throw Exception('Failed to load ingredient suggestions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
