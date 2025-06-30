class Customer {
  final String customerId;
  String name;
  String document;
  String address;
  String email;
  String passwordHash;

  Customer({
    required this.customerId,
    required this.name,
    required this.document,
    required this.address,
    required this.email,
    required this.passwordHash,
  });

  bool login(String email, String password) {
    return this.email == email && this.passwordHash == password;
  }

  void updateProfile(String newName, String newAddress) {
    name = newName;
    address = newAddress;
  }
}
