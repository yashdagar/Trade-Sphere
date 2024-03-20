class StockData {
  dynamic price;
  dynamic change;
  dynamic changePercent;
  dynamic low;
  dynamic high;
  dynamic low52week;
  dynamic high52week;
  dynamic open;
  dynamic peRatio;
  dynamic prevClose;
  dynamic volume;
  dynamic marketCap;

  StockData({
    required this.price,
    required this.marketCap,
    required this.change,
    required this.changePercent,
    required this.low,
    required this.high,
    required this.low52week,
    required this.high52week,
    required this.open,
    required this.peRatio,
    required this.prevClose,
    required this.volume,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      marketCap: json['marketCap'],
      price: json['latestPrice'],
      change: json['change'],
      changePercent: json['changePercent'],
      low: json['low'],
      high: json['high'],
      low52week: json['week52Low'],
      high52week: json['week52High'],
      open: json['iexOpen'],
      peRatio: json['peRatio'],
      prevClose: json['previousClose'],
      volume: json['iexVolume'],
    );
  }

  @override
  String toString() {
    return 'price: $price, '
        'change: $change, '
        'marketCap: $marketCap, '
        'changePercent: $changePercent, '
        'low: $low, '
        'high: $high, '
        'low52week: $low52week, '
        'high52week: $high52week, '
        'open: $open, '
        'peRatio: $peRatio, '
        'prevClose: $prevClose, '
        'volume: $volume}'
    ;
  }
}