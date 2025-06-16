import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Customer {
  final String customerId;
  String name;
  String document;
  String address;
  String email;
  String passwordHash;

  Customer({
    String? customerId,
    required this.name,
    required this.document,
    required this.address,
    required this.email,
    required String password,
  })  : customerId = customerId ?? const Uuid().v4(),
        passwordHash = _hashPassword(password);

  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool login(String email, String password) {
    return this.email == email && passwordHash == _hashPassword(password);
  }

  void updateProfile({
    String? name,
    String? document,
    String? address,
    String? email,
  }) {
    this.name = name ?? this.name;
    this.document = document ?? this.document;
    this.address = address ?? this.address;
    this.email = email ?? this.email;
  }

  // This will be implemented later with database integration
  // List<Account> viewAccounts() => [];

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'name': name,
      'document': document,
      'address': address,
      'email': email,
      'passwordHash': passwordHash,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer._fromMap(
      customerId: map['customerId'],
      name: map['name'],
      document: map['document'],
      address: map['address'],
      email: map['email'],
      passwordHash: map['passwordHash'],
    );
  }

  Customer._fromMap({
    required this.customerId,
    required this.name,
    required this.document,
    required this.address,
    required this.email,
    required this.passwordHash,
  });
}


