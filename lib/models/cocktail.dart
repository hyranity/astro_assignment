import 'package:astro_assignment/models/base_food.dart';

class Cocktail extends BaseFood {
  @override
  String id;

  @override
  String strFood;

  @override
  String strThumb;

  Cocktail(
    this.id,
    this.strFood,
    this.strThumb,
  );

  static Cocktail fromJSON(Map<String, dynamic> json) {
    return Cocktail(
      json['idDrink'],
      json['strDrink'],
      json['strDrinkThumb'],
    );
  }
}
