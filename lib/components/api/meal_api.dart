import 'package:astro_assignment/components/api/base_api.dart';
import 'package:http/http.dart';

class MealApi extends BaseApi {
  @override
  String BASE_URL = "www.themealdb.com/api/json/v1/1";

  @override
  Future<Response> getCategories() {
    return call("/categories.php");
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
