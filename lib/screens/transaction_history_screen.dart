import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_card.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionHistoryScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: transactions.isEmpty
          ? Center(child: Text("No Transactions Yet"))
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return TransactionCard(
              transaction: transactions[index]);
        },
      ),
    );
  }
}
