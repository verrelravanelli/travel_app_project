class UserModel {
  final String id;
  final String email;
  final String name;
  final int balance;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.balance,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "balance": balance,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        balance: json['balance']);
  }
}
