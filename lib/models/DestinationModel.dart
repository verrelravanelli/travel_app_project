class DestinationModel {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final double rating;
  final int price;
  final String about;

  DestinationModel({
    required this.id,
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.about,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "imageUrl": imageUrl,
      "rating": rating,
      "price": price,
      "about": about,
    };
  }

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      price: json['price'],
      about: json['about'],
    );
  }
}
