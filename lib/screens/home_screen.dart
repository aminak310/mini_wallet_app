import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/supabase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double balance = 0.0;
  List<TransactionModel> transactions = [];
  final SupabaseService supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  /// Fetch all transactions from Supabase
  Future<void> fetchTransactions() async {
    try {
      final fetched = await supabaseService.getTransactions();
      setState(() {
        transactions = fetched;
        balance = transactions.fold(
          0.0,
              (sum, t) => t.isCredit ? sum + t.amount : sum - t.amount,
        );
      });
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  /// Add Money
  Future<void> addMoney(double amount) async {
    final transaction = TransactionModel(
      title: "Added Money",
      amount: amount,
      date: DateTime.now(),
      isCredit: true,
    );

    try {
      // Supabase me add karo
      await supabaseService.addTransaction(transaction);

      // Local update
      setState(() {
        transactions.insert(0, transaction);
        balance += amount;
      });

    } catch (e) {
      print("Error adding money: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add money: $e")),
      );
    }
  }

  /// Send Money
  Future<void> sendMoney(double amount) async {
    if (amount > balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient Balance")),
      );
      return;
    }

    final transaction = TransactionModel(
      title: "Sent Money",
      amount: amount,
      date: DateTime.now(),
      isCredit: false,
    );

    try {
      // Supabase me add karo
      await supabaseService.addTransaction(transaction);

      // Local update
      setState(() {
        transactions.insert(0, transaction);
        balance -= amount;
      });

    } catch (e) {
      print("Error sending money: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send money: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Wallet"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await addMoney(100); // test amount
                  },
                  child: const Text("Add Money"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await sendMoney(50); // test amount
                  },
                  child: const Text("Send Money"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Transactions Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Transaction List
            Expanded(
              child: transactions.isEmpty
                  ? const Center(child: Text("No transactions yet"))
                  : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final t = transactions[index];
                  return Card(
                    child: ListTile(
                      title: Text(t.title),
                      subtitle: Text(t.date.toString()),
                      trailing: Text(
                        "${t.isCredit ? "+" : "-"} \$${t.amount}",
                        style: TextStyle(
                          color: t.isCredit ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}