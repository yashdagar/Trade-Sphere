import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/search_results_model.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../models/stock_data_model.dart';
import '../screens/stocks/search/stockDetails/stock_details_screen.dart';

class SearchCard extends StatefulWidget {
  final SearchResults result;
  final int? units;
  const SearchCard({super.key, required this.result, this.units = 0});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  int? units;
  @override
  Widget build(BuildContext context) {
    units ??= widget.units;
    StockData? data;
    return GestureDetector(
      onTap: () async {
        int val = await onCardTap(data, context);
        setState(() => units = val);
      },
      child: FutureBuilder(
        future: getData(widget.result.symbol),
        builder: (context, AsyncSnapshot<StockData> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
            return SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: const Color(0xFF212121),
                highlightColor: const Color(0xFF323232),
                child: Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: 1, color: Color(0xFF212429)),
                  ),
                ),
              ),
            );
          }
          data = snapshot.data;
          return Card(
            color: const Color(0xFF121212),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 1,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(width: 1, color: Color(0xFF212429)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(future: getUrl(widget.result.symbol), builder: (context, AsyncSnapshot<String> snap){
                    if(!snap.hasData || snap.data == ""){
                      return const SizedBox();
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        snap.data!,
                        width: 36,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      '${widget.result.name}${units != 0? "(${widget.result.symbol})" : ""}',
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15,),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  if(units != 0) Text("Units: $units"),
                  const Expanded(child: SizedBox()),
                  if(snapshot.data!.price != null)
                  Text('${snapshot.data!.price} ${widget.result.currency}'),
                  if(snapshot.data!.change != null && snapshot.data!.changePercent != null)
                  Text(
                    '${snapshot.data!.change>=0?"+":""}${snapshot.data!.change} ${widget.result.currency} (${snapshot.data!.changePercent}%)',
                    style: TextStyle(
                      color: snapshot.data!.change>=0?
                      const Color(0xFF50C878):
                      const Color(0xFFFF5733),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<StockData> getData(String symbol) async {
    Response response = await Dio().get("https://api.iex.cloud/v1/data/core/quote/$symbol?token=$stocksApiKey");
    StockData data = StockData.fromJson(response.data[0]);
    return data;
  }

  Future<String> getUrl(String symbol) async {
    Response response = await Dio().get("https://api.iex.cloud/v1/stock/$symbol/logo?token=$stocksApiKey");
    String url = response.data["url"]??"";
    return url;
  }

  onCardTap(StockData? data, BuildContext context) async {
    int? val;
    if(data != null && data.change != null) {
      val = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          StockDetails(stock: widget.result, data: data, units: widget.units)));
    }
    if(val != null){
      return val;
    }
    return widget.units;
  }
}