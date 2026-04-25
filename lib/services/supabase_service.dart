import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transaction.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Fetch all transactions
  Future<List<TransactionModel>> getTransactions() async {
    final data = await supabase
        .from('transactions')
        .select()
        .order('date', ascending: false);

    return (data as List)
        .map((e) => TransactionModel.fromMap(e))
        .toList();
  }

  /// Add a transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await supabase.from('transactions').insert({
      'title': transaction.title,
      'amount': transaction.amount,
      'date': transaction.date.toIso8601String(),
      'is_credit': transaction.isCredit,
    });
  }
}