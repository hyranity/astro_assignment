import 'package:astro_assignment/models/base.dart';

class CocktailItem extends BaseFoodItem {
  @override
  String? id;

  @override
  String? strFood;

  @override
  String? strThumb;

  CocktailItem(
    this.id,
    this.strFood,
    this.strThumb,
  );

  static CocktailItem fromJSON(Map<String, dynamic> json) {
    return CocktailItem(
      json['idDrink'],
      json['strDrink'],
      json['strDrinkThumb'],
    );
  }
}

class CocktailDetails extends BaseFoodDetails {
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

  CocktailDetails(
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

  // From JSON
  static CocktailDetails fromJSON(Map<String, dynamic> json) {
    // Convert strIngredients1, strIngredients2, strIngredients3, ... to List<String>
    // Max JSON result is 15
    List<String> ingredients = [];
    for (int i = 1; i <= 15; i++) {
      if (json['strIngredient$i'] != null) {
        ingredients.add(json['strIngredient$i']);
      }
    }

    // Same goes for measure
    List<String> measures = [];
    for (int i = 1; i <= 15; i++) {
      if (json['strMeasure$i'] != null) {
        measures.add(json['strMeasure$i']);
      }
    }

    return CocktailDetails(
      json['dateModified'],
      json['idDrink'],
      json['strAlcoholic'],
      json['strCategory'],
      json['strCreativeCommonsConfirmed'],
      json['strDrinkAlternate'],
      json['strDrink'],
      json['strDrinkThumb'],
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
      json['strInstructionsZH-HANS'],
      json['strInstructionsZH-HANT'],
      measures,
      json['strTags'],
      json['strVideo'],
    );
  }
}
