import 'package:expense_checker/widgets/chart.dart';
import 'package:expense_checker/widgets/new_transaction.dart';
import 'package:expense_checker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_checker/models/transaction.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Checker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          toolbarTextStyle: Theme.of(context)
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              )
              .bodyText2,
          titleTextStyle: Theme.of(context)
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*late String titleInput;
  late String amountInput;*/
  final List<Trasaction> _userTransactions = [
    // Trasaction(
    //   title: 'New Shoes',
    //   id: 't01',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Trasaction(
    //   title: 'Weekly Groceries',
    //   id: 't02',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Trasaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTx = Trasaction(
        title: txTitle,
        id: DateTime.now().toString(),
        amount: txAmount,
        date: dateTime);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransaction),
          );
        });
  }

  bool _showChart = false;

  List<Widget> _buildLandscape(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txList
    ];
  }

  List<Widget> _buildPotrait(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('My Personal Expense'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('My Personal Expense'),
            actions: [
              IconButton(
                onPressed: () {
                  startAddTransaction(context);
                },
                icon: Icon(Icons.add),
              ),
            ],
          );
    final txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (isLandscape) ..._buildLandscape(mediaQuery, appBar, txList),
              if (!isLandscape) ..._buildPotrait(mediaQuery, appBar, txList),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isWindows
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                startAddTransaction(context);
              },
              child: Icon(Icons.add),
            ),
    );
  }
}
