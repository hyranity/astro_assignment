abstract class BaseFoodItem {
  abstract String? strFood;
  abstract String? strThumb;
  abstract String? id;
}

abstract class BaseFoodDetails {
  abstract String? id;
  abstract String? strFood;
  abstract String? strDrinkAlternate;
  abstract String? strTags;
  abstract String? strVideo;
  abstract String? strFoodThumb;
  abstract String? strCategory;
  abstract String? strIBA;
  abstract String? strAlcoholic;
  abstract String? strGlass;
  abstract String? strInstructions;
  abstract String? strInstructionsES;
  abstract String? strInstructionsDE;
  abstract String? strInstructionsFR;
  abstract String? strInstructionsIT;
  abstract String? strInstructionsZH_HANS;
  abstract String? strInstructionsZH_HANT;
  abstract List<String> strIngredientList;
  abstract List<String> strMeasureList;
  abstract String? strImageSource;
  abstract String? strImageAttribution;
  abstract String? strCreativeCommonsConfirmed;
  abstract String? dateModified;
}
