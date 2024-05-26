import 'dart:convert';

import 'package:amazon_clone/models/address.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<dynamic>? addresses;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.addresses,
    required this.type,
    required this.token,
    required this.cart
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'addresses': addresses,
      'type': type,
      'token': token,
      'cart': cart
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      addresses: List<Map<String,dynamic>>.from(map['addresses']?.map((x) => Map<String, dynamic>.from(x))),
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String,dynamic>>.from(map['cart']?.map((x) => Map<String, dynamic>.from(x)))
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<dynamic>? addresses,
    String? type,
    String? token,
    List<dynamic>? cart

  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      addresses: addresses ?? this.addresses,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart
    );
  }
}
