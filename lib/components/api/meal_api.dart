import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/models/common.dart';
import 'package:astro_assignment/models/meal.dart';

class MealApi extends BaseApi {
  @override
  String BASE_URL = "https://www.themealdb.com/api/json/v1/1";

  @override
  Future getCategories() {
    return call<Category>("/categories.php", Category.fromJson);
  }

  @override
  getDetail(String id) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future getByCategory(String category) {
    return call<Meal>("/filter.php?c=$category", Meal.fromJSON);
  }
}
