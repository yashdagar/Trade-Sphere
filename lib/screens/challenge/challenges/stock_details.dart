import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({super.key, required this.stock, required this.name, required this.symbol});

  final List<double> stock;
  final String name, symbol;

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      appBar: AppBar(),
      body: Column( crossAxisAlignment: CrossAxisAlignment.start,children: [

        const SizedBox(height: 16),
        Text("${widget.name}(${widget.symbol})", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        const SizedBox(height: 16),
        const Text(
          "Current Holdings: 0 units",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '${widget.stock.last} USD',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '${widget.stock.last - widget.stock.first>=0?"+":""}'
                '${(widget.stock.last - widget.stock.first).toStringAsFixed(2)} '
                'USD (${((widget.stock.last - widget.stock.first)/widget.stock.first*100).toStringAsFixed(4)}%)',
            style: TextStyle(color: widget.stock.last - widget.stock.first>=0?
            const Color(0xFF50C878):
            const Color(0xFFFF5733),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AspectRatio(aspectRatio: 1,child: LineChart(
          LineChartData(
            backgroundColor: const Color(0xFF212121),
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: widget.stock.map<FlSpot>((e) => FlSpot(
                    (i++).toDouble(), e))
                    .toList(),
                isCurved: true,
                barWidth: 1,
                gradient: const LinearGradient(colors: [Color(0xFFDA4453), Color(0xFF89216B)]),
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  getTitlesWidget: (val, widget) => SideTitleWidget(
                    space: 1,
                    axisSide: widget.axisSide,
                    child: Text(
                      NumberFormat.compactCurrency(symbol: '\$').format(val),
                      maxLines: 1,
                    ),
                  ),
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
            ),
            gridData: const FlGridData(
              drawVerticalLine: false,
              horizontalInterval: 10,
            ),
          ),
        )),
      ]),
      bottomSheet: Container(
        color: const Color(0xFF212223),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(
              onPressed: () async {},
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: const Color(0xFF40B868),
                fixedSize: Size(MediaQuery.of(context).size.width/2-32, 48),
              ),
              child: Text(
                "Buy",
                style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            FilledButton(
              onPressed: () async {},
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: const Color(0xFFEF4723),
                fixedSize: Size(MediaQuery.of(context).size.width/2-32, 48),
              ),
              child: Text(
                "Sell",
                style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
