class UserModel {
  final String id;
  final String email;
  final String name;
  final int balance;
  final String locationid;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.balance,
      required this.locationid});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "balance": balance,
      "locationid": locationid,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      balance: json['balance'],
      locationid: json['locationid'],
    );
  }
}
