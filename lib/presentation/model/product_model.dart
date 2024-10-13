import 'rate_model.dart';

class ProductModel {
  int id;
  String title;
  dynamic price;
  String image;
  String description;
  String category;
  Rating rating;

  ProductModel({
    required this.id,
    required this.rating,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    return ProductModel(
        id: json?["id"],
        title: json?["title"],
        price: json?["price"],
        image: json?["image"],
        description: json?["description"],
        category: json?["category"],
        rating: Rating.fromJson(json?["rating"])
    );
  }
}

