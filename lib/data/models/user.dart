import 'dart:convert';

class User {
  final String id;
  final String fullname;
  final String email;
  final String? phone;
  final String? phoneNetwork;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.phoneNetwork,
  });

  /// Factory pour créer un objet `User` à partir d'une réponse JSON.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      phoneNetwork: json['phoneNetwork'] as String?,
    );
  }

  /// Méthode pour convertir un objet `User` en un Map JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'phoneNetwork': phoneNetwork,
    };
  }

  /// Méthode statique pour convertir une chaîne JSON en un objet `User`.
  static User fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User.fromJson(json);
  }

  /// Méthode pour convertir un objet `User` en une chaîne JSON.
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
