import 'package:astro_assignment/components/api/base_api.dart';
import 'package:astro_assignment/models/cocktail.dart';
import 'package:astro_assignment/models/common.dart';

class CocktailApi extends BaseApi {
  @override
  String BASE_URL = "https://www.thecocktaildb.com/api/json/v1/1";

  @override
  Future getCategories() {
    return call<Category>("/list.php?c=list", Category.fromJson);
  }

  @override
  getDetail(String id) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future getByCategory(String category) {
    return call<Cocktail>("/filter.php?c=$category", Cocktail.fromJSON);
  }
}
