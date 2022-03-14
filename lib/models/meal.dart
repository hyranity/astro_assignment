import 'package:astro_assignment/models/base.dart';

class MealItem extends BaseFoodItem {
  @override
  String? id;

  @override
  String? strFood;

  @override
  String? strThumb;

  MealItem(
    this.id,
    this.strFood,
    this.strThumb,
  );

  static MealItem fromJSON(Map<String, dynamic> json) {
    return MealItem(
      json['idMeal'],
      json['strMeal'],
      json['strMealThumb'],
    );
  }
}

class MealDetails extends BaseFoodDetails {
  @override
  String? dateModified;

  @override
  String? id;

  @override
  String? strAlcoholic;

  @override
  String? strCategory;

  @override
  String? strCreativeCommonsConfirmed;

  @override
  String? strDrinkAlternate;

  @override
  String? strFood;

  @override
  String? strFoodThumb;

  @override
  String? strGlass;

  @override
  String? strIBA;

  @override
  String? strImageAttribution;

  @override
  String? strImageSource;

  @override
  List<String> strIngredientList;

  @override
  String? strInstructions;

  @override
  String? strInstructionsDE;

  @override
  String? strInstructionsES;

  @override
  String? strInstructionsFR;

  @override
  String? strInstructionsIT;

  @override
  String? strInstructionsZH_HANS;

  @override
  String? strInstructionsZH_HANT;

  @override
  List<String> strMeasureList;

  @override
  String? strTags;

  @override
  String? strVideo;

  MealDetails(
    this.dateModified,
    this.id,
    this.strAlcoholic,
    this.strCategory,
    this.strCreativeCommonsConfirmed,
    this.strDrinkAlternate,
    this.strFood,
    this.strFoodThumb,
    this.strGlass,
    this.strIBA,
    this.strImageAttribution,
    this.strImageSource,
    this.strIngredientList,
    this.strInstructions,
    this.strInstructionsDE,
    this.strInstructionsES,
    this.strInstructionsFR,
    this.strInstructionsIT,
    this.strInstructionsZH_HANS,
    this.strInstructionsZH_HANT,
    this.strMeasureList,
    this.strTags,
    this.strVideo,
  );

  static MealDetails fromJSON(Map<String, dynamic> json) {
    // Convert strIngredients1, strIngredients2, strIngredients3, ... to List<String>
    // Max JSON result is 20
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null) {
        ingredients.add(json['strIngredient$i']);
      }
    }

    // Same goes for measure
    List<String> measures = [];
    for (int i = 1; i <= 20; i++) {
      if (json['strMeasure$i'] != null) {
        measures.add(json['strMeasure$i']);
      }
    }

    return MealDetails(
      json['dateModified'],
      json['id'],
      json['strAlcoholic'],
      json['strCategory'],
      json['strCreativeCommonsConfirmed'],
      json['strDrinkAlternate'],
      json['strMeal'],
      json['strMealThumb'],
      json['strGlass'],
      json['strIBA'],
      json['strImageAttribution'],
      json['strImageSource'],
      ingredients,
      json['strInstructions'],
      json['strInstructionsDE'],
      json['strInstructionsES'],
      json['strInstructionsFR'],
      json['strInstructionsIT'],
      json['strInstructionsZH_HANS'],
      json['strInstructionsZH_HANT'],
      measures,
      json['strTags'],
      json['strVideo'],
    );
  }
}
