class APIModel {
  final String wikiDataID;
  final String city;

  APIModel({
    required this.wikiDataID,
    required this.city,
  });

  factory APIModel.fromJson(Map<String, dynamic> json) {
    return APIModel(
      wikiDataID: json['wikiDataID'],
      city: json['city'],
    );
  }
}
