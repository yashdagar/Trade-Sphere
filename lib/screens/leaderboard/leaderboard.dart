import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../models/leaderboard_model.dart';
import '../../models/user_data_model.dart';
import '../../widgets/leaderboard_card.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard")),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<List<LeaderboardStat>> snapshot){
          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return const Column(
              children: [
                Center(
                  child: Text("No stats available"),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  LeaderboardStat stat = snapshot.data![index];
                  return LeaderboardCard(stat: stat);
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<LeaderboardStat>> getData() async {
    List<LeaderboardStat> stats = [];
    DatabaseEvent dataSnapshot = await FirebaseDatabase.instance.ref().orderByChild("currentWorth").limitToFirst(40).once();
    for(DataSnapshot snapshot in dataSnapshot.snapshot.children){
      UserData userData = UserData.fromSnapshot(snapshot);
      if(userData.name != "") {
        stats.add(LeaderboardStat(
          netWorth: userData.worth,
          name: userData.name,
          url: userData.url,
          index: dataSnapshot.snapshot.children.length - stats.length,
        ));
      }
    }
    stats.sort((a,b) => a.index.compareTo(b.index));
    return stats;
  }
}
