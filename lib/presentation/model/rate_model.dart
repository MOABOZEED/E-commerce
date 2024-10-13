
class Rating {
  dynamic rate;
  dynamic count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic>? json) {
    return Rating(rate: json?["rate"], count: json?["count"]);
  }
}

