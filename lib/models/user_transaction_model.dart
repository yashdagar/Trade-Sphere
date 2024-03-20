enum TransactionType{ buy, sell }

class UserTransaction{
  final DateTime time;
  final String symbol, name, url;
  final int units;
  final double price;
  final TransactionType type;

  UserTransaction({
    required this.time,
    required this.symbol,
    required this.name,
    required this.url,
    required this.units,
    required this.price,
    required this.type,
  });

  factory UserTransaction.fromMap(Map map) => UserTransaction(
      time: DateTime.fromMillisecondsSinceEpoch(map["time"]),
      symbol: map["symbol"],
      name: map["name"],
      url: map["url"],
      units: map["units"],
      price: map["price"],
      type: TransactionType.values.firstWhere((e) => e.name == map["transactionType"]),
    );


  @override
  String toString() {
    return "time: ${time.toIso8601String()}, symbol: $symbol, units: $units, type: ${type.name}";
  }
}