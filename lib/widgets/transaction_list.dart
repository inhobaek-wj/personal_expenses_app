import 'package:flutter/material.dart';

import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      // height: 300,
      child: transactions.isEmpty ?

      LayoutBuilder(
        builder: (ctx, constrains) {
          return Column(
            children: <Widget>[
              Text('No transaction added yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              Container(
                height: constrains.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover
                ),
              )
            ],
          );
        }
      )

      : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return TransactionItem(
            transaction: transactions[index],
            deleteTx: deleteTx
          );
        },
        // children: transactions.map((tx) {
        //     return
        // }).toList(),
      ),
    );
  }

}


