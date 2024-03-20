import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../models/user_data_model.dart';

class BuyStocksScreen extends StatefulWidget {
  const BuyStocksScreen({
    Key? key,
    required this.url,
    required this.userData,
    required this.stockPrice,
    required this.name,
    required this.symbol,
    required this.currency,
  }) : super(key: key);

  final String url;
  final String name;
  final String currency;
  final String symbol;
  final UserData userData;
  final double stockPrice;

  @override
  State<BuyStocksScreen> createState() => _BuyStocksScreenState();
}

class _BuyStocksScreenState extends State<BuyStocksScreen> {
  int numberOfUnits = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  fillColor: const Color(0xFF060606),
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
                  side: const BorderSide(color: Color(0xFF212223))
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
                          Text("\$${(widget.userData.currentBalance - widget.stockPrice * numberOfUnits).toStringAsFixed(4)}"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => buyStocks(
                          (widget.userData.currentBalance - widget.stockPrice * numberOfUnits).toDouble(),
                          numberOfUnits,
                        ),
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text("Buy"),
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

  void buyStocks(double val, int units) {
    if(val < 0){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You don't have enough money", style: TextStyle(color: Colors.white),),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(8),
            backgroundColor: Color(0xFF212121),
          )
      );
      return;
    }
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
    FirebaseDatabase.instance.ref().child(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({"currency": val});

    FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child("stocks")
        .child(widget.symbol)
        .update({
      "units": (widget.userData.stocks.where((e) => e.symbol == widget.symbol).firstOrNull?.units ?? 0) + units,
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
      "transactionType": "buy",
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Purchased stocks are viewable on the Stocks screen", style: TextStyle(color: Colors.white),),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(8),
          backgroundColor: Color(0xFF212121),
        )
    );
    Navigator.pop(context, (widget.userData.stocks.where((e) => e.symbol == widget.symbol).firstOrNull?.units ?? 0) + units);
    return;
  }
}