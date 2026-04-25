import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  final Function(double) onSend;

  const SendMoneyScreen({required this.onSend});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    double amount = double.tryParse(_controller.text) ?? 0;
    if (amount > 0) {
      widget.onSend(amount);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Money")),
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
              child: Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}
