class TransactionModel {

  final int? id;
  final String title;
  final double amount;
  final String type;

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'type': type,
    };
  }
}