import 'package:intl/intl.dart';

class StockPrices {
  dynamic average;
  dynamic date;
  StockPrices({required this.average,required this.date,});
  factory StockPrices.fromMap(Map<String, dynamic> map) {
    return StockPrices(average: map['average'], date: DateFormat("yyyy-MM-dd hh:mm a").tryParse(map["date"] + " " + map["label"]));
  }
}