class SearchResults {
  String symbol, currency, name;
  SearchResults({required this.symbol, required this.name, required this.currency});
  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
    symbol: json['symbol'] ?? '',
    name: json['name']?? '',
    currency: json['currency'] ?? '',
  );
}