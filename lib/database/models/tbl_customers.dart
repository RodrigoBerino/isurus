class TblCustomer {
  final String id;
  final String name;
  final String document;
  final String email;
  final String address;
  final String passwordHash;

  TblCustomer({
    required this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.address,
    required this.passwordHash,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'document': document,
      'email': email,
      'address': address,
      'password_hash': passwordHash,
    };
  }

  factory TblCustomer.fromMap(Map<String, dynamic> map) {
    return TblCustomer(
      id: map['id'],
      name: map['name'],
      document: map['document'],
      email: map['email'],
      address: map['address'],
      passwordHash: map['password_hash'],
    );
  }
}