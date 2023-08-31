class Product {
  String name;
  int price1;
  int? price2;
  String? category;
  String? description;
  String? image;

  Product({
    required this.name,
    required this.price1,
    this.price2,
    this.category,
    this.description,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price1': price1,
      'price2': price2,
      'category': category,
      'description': description,
      'image': image,
    };
  }
}
