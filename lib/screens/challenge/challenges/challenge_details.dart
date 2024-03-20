import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'stocks_list.dart';

class Challenge1 extends StatefulWidget {
  const Challenge1({super.key});

  @override
  State<Challenge1> createState() => _Challenge1State();
}

class _Challenge1State extends State<Challenge1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Market Challenges: Chapter 1", style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 16),
            const Text("Explore financial history with our Market Challenges. Spend gems to unlock scenarios based on real-world events and stock prices. Navigate market highs and lows, make strategic decisions, and gain valuable insights into past investor experiences. Ready to test your investment skills? Dive into the Market Challenges now!"
              , style: TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,),
              const SizedBox(height: 32),
            ElevatedButton(onPressed: () async {
              DataSnapshot snapshot = await FirebaseDatabase.instance.ref()
                  .child(FirebaseAuth.instance.currentUser!.uid)
                  .child("contests")
                  .get();

              if(snapshot.value.runtimeType == int && DateTime.fromMillisecondsSinceEpoch(snapshot.value as int).minute > 30){
                  FirebaseDatabase.instance.ref()
                      .child(FirebaseAuth.instance.currentUser!.uid)
                      .child("contests").remove();
                }
              else if(snapshot.value == null) {
                DatabaseReference ref = FirebaseDatabase.instance.ref()
                    .child(FirebaseAuth.instance.currentUser!.uid)
                    .child("contests").push();
                ref.set(ServerValue.timestamp);
              }
              if (mounted) {
                if(snapshot.children.isNotEmpty){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                            StocksList(
                                startTime: DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.children.first.value as int))));
                  }else{
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            StocksList(startTime: DateTime.now())));
                  }
                }

            }, child: const Text("Join")),
          ]),
        ),
      ),
    );
  }
}
