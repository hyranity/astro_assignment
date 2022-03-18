import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/models/common.dart';
import 'package:astro_assignment/models/meal.dart';

class MealApi extends BaseApi {
  @override
  String BASE_URL = "https://www.themealdb.com";

  @override
  Future getCategories() {
    return call<Category>("/categories.php", Category.fromJson);
  }

  @override
  Future getDetail(String id) {
    return call<MealDetails>("/lookup.php?i=$id", MealDetails.fromJSON);
  }

  @override
  Future getByCategory(String category) {
    return call<MealItem>("/filter.php?c=$category", MealItem.fromJSON);
  }
}
