class TblTransaction {
  final String id;
  final String contaId;
  final String date;
  final double quantity;
  final String type;
  final String description;

  TblTransaction({
    required this.id,
    required this.contaId,
    required this.date,
    required this.quantity,
    required this.type,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conta_id': contaId,
      'date': date,
      'quantity': quantity,
      'type': type,
      'description': description,
    };
  }

  factory TblTransaction.fromMap(Map<String, dynamic> map) {
    return TblTransaction(
      id: map['id'],
      contaId: map['conta_id'],
      date: map['date'],
      quantity: map['quantity'],
      type: map['type'],
      description: map['description'],
    );
  }
}