class MenuItemModel {
  String title;
  String imageURL;
  num totalItems;

  MenuItemModel({
    required this.title,
    required this.imageURL,
    this.totalItems = 0,
  });
}
