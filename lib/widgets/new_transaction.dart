import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(
    this.onSumit,
  );

  final amountController = TextEditingController();
  final Function onSumit;
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              onPressed: (() => onSumit(
                  titleController.text, double.parse(amountController.text))),
              child: const Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}
