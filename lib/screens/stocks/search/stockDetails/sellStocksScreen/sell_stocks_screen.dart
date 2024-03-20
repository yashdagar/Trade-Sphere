import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../models/user_data_model.dart';

class SellStocksScreen extends StatefulWidget {
  const SellStocksScreen({
    super.key,
    required this.url,
    required this.name,
    required this.stockPrice,
    required this.userData,
    required this.currency,
    required this.symbol,
  });
  final String url;
  final String name;
  final String symbol;
  final String currency;
  final double stockPrice;
  final UserData userData;

  @override
  State<SellStocksScreen> createState() => _SellStocksScreenState();
}

class _SellStocksScreenState extends State<SellStocksScreen> {

  int numberOfUnits = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Column(children: [
                if(widget.url != "")
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.url,
                      width: 144,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ),
                const SizedBox(height: 16,),
                Text(
                  widget.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],),),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    setState(() => numberOfUnits = int.tryParse(value) ?? 0),
                decoration: InputDecoration(
                  hintText: "Enter the number of units",
                  hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                  filled: true,
                  fillColor: const Color(0xFF060709),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Color(0xFF212223),width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,width: 1.5),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
              const SizedBox(height: 32.0),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFF121315))
                ),
                color: const Color(0xFF121212),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Value"),
                          Text("Price"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Balance", style: TextStyle(color: Color(0xFF888888))),
                          Text("\$${(widget.userData.currentBalance).toStringAsFixed(4)}", style: const TextStyle(color: Color(0xFF888888))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Stock price", style: TextStyle(color: Color(0xFF888888))),
                          Text("\$${(widget.stockPrice * numberOfUnits).toStringAsFixed(4)}", style: const TextStyle(color: Color(0xFF888888))),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(thickness: 0.7,),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Total"),
                          Text("\$${(widget.userData.currentBalance + widget.stockPrice * numberOfUnits).toStringAsFixed(4)}"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => sellStocks(
                          (widget.userData.currentBalance + widget.stockPrice * numberOfUnits).toDouble(),
                          numberOfUnits,
                          widget.userData.stocks.where((e) => e.symbol == widget.symbol).isNotEmpty?
                          widget.userData.stocks.firstWhere((e) => e.symbol == widget.symbol).units:
                          0
                        ),
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text("Sell"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sellStocks(double value, int units, int prevUnits) {
    if(units <= 0){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Number of units can not be 0", style: TextStyle(color: Colors.white),),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(8),
            backgroundColor: Color(0xFF212121),
          )
      );
      return;
    }
    if(prevUnits - units < 0){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You don't have enough units", style: TextStyle(color: Colors.white),),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(8),
            backgroundColor: Color(0xFF212121),
          )
      );
      return;
    }

    FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child("stocks")
        .child(widget.symbol)
        .update({
      "units": prevUnits - units,
      "currency": widget.currency,
      "name": widget.name,
      "symbol": widget.symbol,
      "rate": widget.stockPrice,
      "time": ServerValue.timestamp,
    });

    FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child("transactionHistory").push().update({
      "time": ServerValue.timestamp,
      "symbol": widget.symbol,
      "name": widget.name,
      "url": widget.url,
      "price": widget.stockPrice,
      "units": units,
      "transactionType": "sell",
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Stocks sold successfully.", style: TextStyle(color: Colors.white),),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(8),
          backgroundColor: Color(0xFF212121),
        )
    );
    Navigator.pop(context, prevUnits - units);
    return;
  }
}
