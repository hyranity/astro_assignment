import 'package:astro_assignment/models/base_food.dart';

class Meal extends BaseFood {
  @override
  String id;

  @override
  String strFood;

  @override
  String strThumb;

  Meal(
    this.id,
    this.strFood,
    this.strThumb,
  );

  static Meal fromJSON(Map<String, dynamic> json) {
    return Meal(
      json['idMeal'],
      json['strMeal'],
      json['strMealThumb'],
    );
  }
}
