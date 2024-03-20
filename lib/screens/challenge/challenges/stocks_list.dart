import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'news.dart';
import 'stock_details.dart';
import '../../../constants.dart';

class StocksList extends StatefulWidget {
  const StocksList({super.key, required this.startTime});

  final DateTime startTime;

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  int len = 20, remainingSeconds = 1800;

  @override
  void initState() {
    super.initState();

    len = 20;

    remainingSeconds = 1800;
    Timer.periodic(const Duration(seconds: 30), (_) {if(mounted){
      setState(() => len+= 2);
    }});
  }

  @override
  Widget build(BuildContext context) {
    String val = headlines.join("\n");
    List<String> names = [
      "Stratis Motors Ltd.",
      "EcoSolutions Energy Inc.",
      "Global Retail Ventures",
      "BioPharm Innovations Inc.",
      "AeroTech Solutions Ltd.",
    ];
    List<String> symbols = ["STMT", "ECOEN", "GRV", "BIOIN", "AEROT"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapter 1"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeNews(headlines: headlines))),
            child: SizedBox(
              height: 24,
              child: Marquee(
                text: val,
                style: const TextStyle(fontSize: 16.0),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 16.0,
                velocity: 100.0,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 5,
              itemBuilder: (context, index){
                List<double> stock = stocks[index].sublist(0, len);
                double change = stock.last - stock.first;
                double changePercent = change/stock.first*100;
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      StockDetails(stock: stock, name: names[index], symbol: symbols[index]))),
                  child: Card(
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
                          Flexible(
                            child: Text(
                              '${names[index]}(${symbols[index]})',
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15,),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text('${stock.last} USD'),
                          Text(
                            '${change>=0?"+":""}${change.toStringAsFixed(2)} USD (${changePercent.toStringAsFixed(2)}%)',
                            style: TextStyle(
                              color: change>=0?
                              const Color(0xFF50C878):
                              const Color(0xFFFF5733),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void lenIncrease() {
    Timer.periodic(const Duration(seconds: 30), (_) {if(mounted){
      setState(() => len+= 2);
    }});
  }

  void countdownDecrease() {
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     if (remainingSeconds > 0) {
    //       remainingSeconds--;
    //     } else {
    //       timer.cancel();
    //     }
    //   });
    // });
  }
}
