import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/models/common.dart';

class MealApi extends BaseApi {
  @override
  String BASE_URL = "https://www.themealdb.com/api/json/v1/1";

  @override
  Future getCategories<T>() {
    return call<T>("/categories.php", Category.fromJson);
  }

  @override
  getDetail(String id) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  getPopularItems() {
    // TODO: implement getPopularItems
    throw UnimplementedError();
  }
}
