class TblCard {
  final String id;
  final String contaId;
  final String customerId;
  final String expirationDate;
  final String cvv;
  final String cardType;
  final String status;

  TblCard({
    required this.id,
    required this.contaId,
    required this.customerId,
    required this.expirationDate,
    required this.cvv,
    required this.cardType,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conta_id': contaId,
      'customer_id': customerId,
      'expiration_date': expirationDate,
      'cvv': cvv,
      'card_type': cardType,
      'status': status,
    };
  }

  factory TblCard.fromMap(Map<String, dynamic> map) {
    return TblCard(
      id: map['id'],
      contaId: map['conta_id'],
      customerId: map['customer_id'],
      expirationDate: map['expiration_date'],
      cvv: map['cvv'],
      cardType: map['card_type'],
      status: map['status'],
    );
  }
}
