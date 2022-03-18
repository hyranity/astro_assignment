import 'dart:convert';

import 'package:astro_assignment/components/api/cocktail_api.dart';
import 'package:astro_assignment/components/api/meal_api.dart';
import 'package:http/http.dart';

typedef FromJson(Map<String, dynamic> json);

abstract class BaseApi {
  abstract String BASE_URL;

  // A method to generate Api based on type of recipe (eg. Food or Beverage)
  // Supports dynamic type of recipe
  static BaseApi getApi(String type) {
    // Maps type to API
    var apiTypes = {
      "Food": MealApi(),
      "Beverages": CocktailApi(),
    };

    // Return the api based on type if exists, defaults to MealApi
    return apiTypes[type] ?? MealApi();
  }

  Future call<T>(String url, FromJson fromJson) async {
    var response = await get(Uri.parse("${BASE_URL}/api/json/v1/1/${url}"));

    // Throw error if response failed
    if (response.statusCode != 200) {
      throw Exception("Failed to load data: ${response.request?.url}");
    }

    final Map<String, dynamic> parsed = json.decode(response.body);

    // Determine if the child of the first key is an array
    if (parsed.values.first is List) {
      return List<T>.from(
          parsed.values.first.map((json) => fromJson(json) as T));
    } else {
      return fromJson(parsed) as T;
    }
  }

  String getIngredientImage(String ingredient) {
    return "$BASE_URL/images/ingredients/${ingredient.replaceAll(' ', '_')}.png";
  }

  // Methods to be implemented by child classes
  Future getCategories();
  Future getByCategory(String category);
  getDetail(String id);
}
