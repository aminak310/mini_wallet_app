import 'package:flutter/material.dart';

class AddMoneyScreen extends StatefulWidget {
  final Function(double) onAdd;

  const AddMoneyScreen({required this.onAdd});

  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    double amount = double.tryParse(_controller.text) ?? 0;
    if (amount > 0) {
      widget.onAdd(amount);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Money")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
