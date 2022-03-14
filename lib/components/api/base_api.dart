import 'dart:convert';

import 'package:http/http.dart';

typedef FromJson(Map<String, dynamic> json);

abstract class BaseApi {
  abstract String BASE_URL;

  Future call<T>(String url, FromJson fromJson) async {
    var response = await get(Uri.parse("${BASE_URL}/${url}"));

    // Throw error if response failed
    if (response.statusCode != 200) {
      throw Exception("Failed to load data: ${response.request?.url}");
    }

    final Map<String, dynamic> parsed = json.decode(response.body);

    // Determine if the child of the first key is an array
    if (parsed.values.first is List) {
      return List<T>.from(
          parsed.values.first.map((json) => fromJson(json) as T));
    } else {
      return fromJson(parsed) as T;
    }
  }

  Future getCategories();
  Future getByCategory(String category);
  getDetail(String id);
}
