class TblConta {
  final String id;
  final String customerId;
  final double balance;
  final String openDate;
  final String status;
  final String type;

  TblConta({
    required this.id,
    required this.customerId,
    required this.balance,
    required this.openDate,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'balance': balance,
      'open_date': openDate,
      'status': status,
      'type': type,
    };
  }

  factory TblConta.fromMap(Map<String, dynamic> map) {
    return TblConta(
      id: map['id'],
      customerId: map['customer_id'],
      balance: map['balance'],
      openDate: map['open_date'],
      status: map['status'],
      type: map['type'],
    );
  }
}
