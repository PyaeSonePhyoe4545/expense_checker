import 'package:expense_checker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_checker/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Trasaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Transaction yet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView(
            children: userTransactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      deleteTx: deleteTx,
                      userTransaction: tx,
                    ))
                .toList(),
          );
  }
}
