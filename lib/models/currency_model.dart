class CurrencyModel {
  String? symbol;
  double? price;
  double? changesPercentage;
  double? change;
  double? dayLow;
  double? dayHigh;
  double? yearHigh;
  double? yearLow;
  double? marketCap;
  double? priceAvg50;
  double? priceAvg200;
  int? volume;
  int? avgVolume;
  String? exhange;
  double? open;
  double? previousClose;
  void eps;
  void pe;
  void earningsAnnouncement;
  void sharesOutstanding;
  int? timestamp;

  CurrencyModel(
      {this.symbol,
        this.price,
        this.changesPercentage,
        this.change,
        this.dayLow,
        this.dayHigh,
        this.yearHigh,
        this.yearLow,
        this.marketCap,
        this.priceAvg50,
        this.priceAvg200,
        this.volume,
        this.avgVolume,
        this.exhange,
        this.open,
        this.previousClose,
        this.eps,
        this.pe,
        this.earningsAnnouncement,
        this.sharesOutstanding,
        this.timestamp});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    price = json['price'];
    changesPercentage = json['changesPercentage'];
    change = json['change'];
    dayLow = json['dayLow'];
    dayHigh = json['dayHigh'];
    yearHigh = json['yearHigh'];
    yearLow = json['yearLow'];
    marketCap = json['marketCap'];
    priceAvg50 = json['priceAvg50'];
    priceAvg200 = json['priceAvg200'];
    volume = json['volume'];
    avgVolume = json['avgVolume'];
    exhange = json['exhange'];
    open = json['open'];
    previousClose = json['previousClose'];
    eps = json['eps'];
    pe = json['pe'];
    earningsAnnouncement = json['earningsAnnouncement'];
    sharesOutstanding = json['sharesOutstanding'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['price'] = price;
    data['changesPercentage'] = changesPercentage;
    data['change'] = change;
    data['dayLow'] = dayLow;
    data['dayHigh'] = dayHigh;
    data['yearHigh'] = yearHigh;
    data['yearLow'] = yearLow;
    data['marketCap'] = marketCap;
    data['priceAvg50'] = priceAvg50;
    data['priceAvg200'] = priceAvg200;
    data['volume'] = volume;
    data['avgVolume'] = avgVolume;
    data['exhange'] = exhange;
    data['open'] = open;
    data['previousClose'] = previousClose;
    data['eps'] = "";
    data['pe'] = "pe";
    data['earningsAnnouncement'] = "";
    data['sharesOutstanding'] = "";
    data['timestamp'] = timestamp;
    return data;
  }
}