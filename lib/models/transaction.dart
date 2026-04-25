class TransactionModel {
  final String title;
  final double amount;
  final DateTime date;
  final bool isCredit;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.isCredit,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date']),
      isCredit: map['is_credit'],
    );
  }
}