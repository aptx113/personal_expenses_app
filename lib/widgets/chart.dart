import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(
    this.recentTransactions,
  );

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }

  double get totalSpending => groupedTransactionValues.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element['amount'] as double));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues
                .map((data) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          label: data['day'].toString(),
                          spendingAmount: data['amount'] as double,
                          spendingPctOfTotal: totalSpending == 0.0
                              ? 0.0
                              : (data['amount'] as double) / totalSpending),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
