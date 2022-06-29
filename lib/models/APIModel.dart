class APIModel {
  final String wikiDataId;
  final String city;

  APIModel({
    required this.wikiDataId,
    required this.city,
  });

  factory APIModel.fromJson(Map<String, dynamic> json) {
    return APIModel(
      wikiDataId: json['wikiDataId'],
      city: json['city'],
    );
  }
}
