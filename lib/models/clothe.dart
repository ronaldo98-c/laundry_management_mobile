class Clothe {
  int clotheId;
  String category;
  String? brand;
  double? size;
  String? color;
  int quantity;
  double? ironingPercentage;
  String createdAt;

  Clothe({required this.clotheId, required this.category, this.brand, required this.size, this.color, required this.quantity, this.ironingPercentage, required this.createdAt});

  factory Clothe.fromJson(Map<String, dynamic> json) {
    return Clothe(
      clotheId: json['clothe_id'],
      category: json['category'],
      brand: json['brand'],
      size: json['size'],
      color: json['color'],
      quantity: json['quantity'],
      ironingPercentage: json['ironing_percentage'],
      createdAt: json['created_at']
    );
  }
}