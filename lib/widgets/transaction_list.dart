import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          return Card(
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5
            ),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                  ),
                )
              ),

              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline6
              ),

              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),

              trailing: mediaQuery.size.width > 460 ?
              FlatButton.icon(
                label: Text('Delete'),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transactions[index].id),
              )
              : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },
        // children: transactions.map((tx) {
        //     return
        // }).toList(),
      ),
    );
  }

}
