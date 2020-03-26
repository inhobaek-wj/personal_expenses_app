import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());

  // // these code below should be under runApp(MyApp()), otherwise error occurs;
  // SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  // ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          button: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _showChart = false;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          //  actually, without these below code, it is working.
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now()
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly groceries',
    //   amount: 16.53,
    //   date: DateTime.now()
    // ),
  ];

  void _addNewTransaction(String title, double amount, DateTime pickedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: pickedDate
    );

    setState(() {
        _userTransaction.add(newTx) ;
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7)
          )
        );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
        _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,

      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart'),
              Switch(
                value: _showChart,
                onChanged: (bool value) {
                  setState(() {
                      _showChart = value;
                  });
                },
              )
            ],
          ),

          _showChart ? Container(
            height: (MediaQuery.of(context).size.height
              - appBar.preferredSize.height
              - MediaQuery.of(context).padding.top) * 0.7,
            child: Chart(_recentTransactions)
          ) :

          Container(
            height: (MediaQuery.of(context).size.height
              - appBar.preferredSize.height
              - MediaQuery.of(context).padding.top) * 0.7,
            child: TransactionList(_userTransaction,_deleteTransaction)
          )
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
