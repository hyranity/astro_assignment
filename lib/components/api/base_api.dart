import 'package:http/http.dart';

abstract class BaseApi {
  abstract String BASE_URL;

  Future<Response> call(String url) {
    return get(Uri.parse(url));
  }

  getCategories();
  getPopularItems();
  getDetail(String id);
}
