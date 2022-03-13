class Category {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Category(
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  );

  static Category fromJson(Map json) {
    return Category(
      json['idCategory'] ?? '',
      json['strCategory'] ?? '',
      json['strCategoryThumb'] ?? '',
      json['strCategoryDescription'] ?? '',
    );
  }
}
