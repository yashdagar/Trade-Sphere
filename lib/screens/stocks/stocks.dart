import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../models/search_results_model.dart';
import '../Stocks/profile/profile.dart';
import 'search/search.dart';
import '../../models/user_data_model.dart';
import '../../widgets/search_card.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TradeSphere"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
          }, icon: const Icon(Ionicons.search_outline)),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () async {
              UserData userData = await getData();
              if(mounted) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfileScreen(userData: userData),
                ));
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!, width: 32),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref()
            .child(FirebaseAuth.instance.currentUser!.uid).onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> event){
          if(!event.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          UserData userData = UserData.fromSnapshot(event.data!.snapshot);
          List<Stock> holdings = userData.stocks.where((e) => e.units != 0).toList();
          return RefreshIndicator(onRefresh: () async => setState((){}), child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Your Holdings",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: holdings.isNotEmpty?
                GridView.builder(
                  itemCount: holdings.length,
                  itemBuilder: (context, index) =>holdings[index].units !=0? SearchCard(
                    result: SearchResults(
                      symbol:holdings[index].symbol,
                      name: holdings[index].name,
                      currency:holdings[index].currency,
                    ),
                    units: holdings[index].units,
                  ): const SizedBox(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.9,
                  ),
                ):
                Column(children: [Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(height: 32),
                  SvgPicture.asset("images/not_found_404.svg", height: 160),
                  const SizedBox(height: 16.0),
                  const Text('Click on the search button to add stocks'),
                ]))]),
              ),
            ]),
          ));
        },
      ),
    );
  }
  Future<UserData> getData() async {
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref()
        .child(FirebaseAuth.instance.currentUser!.uid).get();
    return UserData.fromSnapshot(snapshot);
  }
}