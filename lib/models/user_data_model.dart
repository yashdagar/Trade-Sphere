import 'user_transaction_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UserData{
  final double currentBalance;
  final List<Stock> stocks;
  final List<UserTransaction> transactions;
  final String name, url;
  final double worth;

  UserData({required this.worth, required this.name, required this.url, required this.transactions, required this.currentBalance, required this.stocks});

  factory UserData.fromSnapshot(DataSnapshot snapshot){
    double a = snapshot.child("currency").value as double;
    List<Stock> stocks = [];
    if (snapshot.child("stocks").value != null) {
      (snapshot.child("stocks").value as Map).forEach((key, value) {
        stocks.add(Stock(
          currency: value["currency"],
          symbol: key,
          units: value["units"],
          time: DateTime.fromMillisecondsSinceEpoch(value["time"]),
          rate: value["rate"],
          name: value["name"],
        ));
      });
    }
    List<UserTransaction> transactions = [];
    if (snapshot.child("transactionHistory").value != null) {
      (snapshot.child("transactionHistory").value as Map)
          .forEach((key, value) {
            transactions.add(UserTransaction.fromMap(value as Map));
      });
    }
    return UserData(
      currentBalance: a,
      stocks: stocks,
      transactions: transactions,
      name: snapshot.child("name").value as String? ?? "",
      url: snapshot.child("url").value as String? ?? "",
      worth: snapshot.child("currentWorth").value as double? ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'UserData(currentBalance: $currentBalance, stocks: $stocks, transactions: $transactions)';
  }
}

class Stock{
  final int units;
  final String currency;
  final String symbol;
  final String name;
  final DateTime time;
  final double rate;

  Stock({
    required this.time,
    required this.rate,
    required this.currency,
    required this.symbol,
    required this.units,
    required this.name,
  });
}