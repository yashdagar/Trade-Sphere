import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../models/user_data_model.dart';
import '../../../models/user_transaction_model.dart';
import 'package:timeago/timeago.dart' as time_ago;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userData});

  final UserData userData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  User user = FirebaseAuth.instance.currentUser!;
  int isSelected = 0;
  String? type;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.displayName!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text(user.email!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF888888))),
                      ],
                    ),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF212223),
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: Image.network(
                          user.photoURL!,
                          errorBuilder: (_,__,___) => const SizedBox(),
                          width: 72,
                          fit: BoxFit.contain,
                          height: 72,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,children: [
                FutureBuilder(
                  future: getWorth(),
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if(!snapshot.hasData || snapshot.data == 0){
                      return const SizedBox();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Chip(
                          labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          label: Text(
                            "${snapshot.data! > 1000000?"+":""}${((snapshot.data! - 1000000)/10000).toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: snapshot.data! > 1000000?
                              const Color(0xFF2eb85c):
                              const Color(0xFFE34E30),
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: snapshot.data! > 1000000?
                          const Color(0xFF004614):
                          const Color(0xFF471400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: BorderSide(color: snapshot.data! > 1000000?
                            const Color(0xFF2eb85c):
                            const Color(0xFFA9290F)),
                          ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text(
                            "\$${snapshot.data?.toStringAsFixed(2) ?? ""}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],),
                        const Text("Total Worth", style: TextStyle(color: Color(0xFF888888))),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                FutureBuilder(
                  future: getBalance(),
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if(!snapshot.hasData || snapshot.data == 0){
                      return const SizedBox();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 48,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text(
                            "\$${snapshot.data?.toStringAsFixed(2) ?? ""}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],),
                        const Text("Current Balance", style: TextStyle(color: Color(0xFF888888))),
                        const SizedBox(height: 32),
                      ],
                    );
                  },
                ),
              ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Transaction History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                            isSelected = 0;
                            type = null;
                          }),
                        child: Chip(
                          label: Text("All", style: TextStyle(color: Color(isSelected == 0 ? 0xFFfafafa : 0xFF888888))),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(isSelected == 0 ? 0x00000000 : 0xFF889095)),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          backgroundColor: Color(isSelected == 0 ? 0xFF424448: 0xFF121212),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() {
                          isSelected = 1;
                          type = "buy";
                        }),
                        child: Chip(
                          label: Text("Buy", style: TextStyle(color: Color(isSelected == 1 ? 0xFFfafafa : 0xFF888888))),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: BorderSide(color: Color(isSelected == 1 ? 0x00000000 : 0xFF889095)),
                          ),
                          backgroundColor: Color(isSelected == 1 ? 0xFF424448: 0xFF121212),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() {
                            isSelected = 2;
                            type = "sell";
                          }),
                        child: Chip(
                          label: Text("Sell", style: TextStyle(color: Color(isSelected == 2? 0xFFfafafa: 0xFF888888))),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: BorderSide(color: Color(isSelected == 2? 0x00000000: 0xFF889095)),
                          ),
                          backgroundColor: Color(isSelected == 2 ? 0xFF424448: 0xFF121212),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FutureBuilder(
                      future: getTransactions(type),
                      builder: (BuildContext context, AsyncSnapshot<List<UserTransaction>> data) {
                        if(!data.hasData || data.data == null || data.data!.isEmpty) {
                          return const Center(child: Text("No Transactions",
                            style: TextStyle(color: Color(0xFF888888)),));
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.data!.length,
                          itemBuilder: (context, int index) {
                        UserTransaction transaction = data.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      transaction.url,
                                      errorBuilder: (_,__,___) => const SizedBox(),
                                      width: 48,
                                      fit: BoxFit.contain,
                                      height: 48,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transaction.symbol,
                                        style: const TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "(${transaction.name.length>20? "${transaction.name.substring(0,17)}...": transaction.name})",
                                        style: const TextStyle(fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Column(
                                    children: [
                                      Text(
                                        "${transaction.units} units",
                                        style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFeeeeee)),
                                      ),
                                      Text(
                                        "${transaction.type != TransactionType.buy?
                                        "+":"-"}${(transaction.price * transaction.units).toStringAsFixed(2)} USD",
                                        style: TextStyle(
                                          color: transaction.type != TransactionType.buy?
                                          const Color(0xFF50C878):
                                          const Color(0xFFFF5733),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                time_ago.format(transaction.time, locale: 'en_short'),
                              ),
                            ],
                          ),
                        );
                                                  },
                                                );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<double> getWorth() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("currentWorth").get();
    return snapshot.value as double? ?? 0.0;
  }

  Future<double> getBalance() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance.ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("currency").get();
    return snapshot.value as double? ?? 0.0;
  }

   Future<List<UserTransaction>> getTransactions(String? type) async {
    Query query = FirebaseDatabase.instance.ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("transactionHistory");
    DataSnapshot snapshot;
    if(type != null && type != "") {
      DatabaseEvent event = await query.orderByChild("transactionType").equalTo(type).limitToFirst(40).once();
      snapshot = event.snapshot;
    }else{
      snapshot = await query.limitToFirst(40).get();
    }
    if(!snapshot.exists){
      return [];
    }
    List<UserTransaction> transactions = (snapshot.value as Map).values.toList()
        .map<UserTransaction>((e) => UserTransaction.fromMap(e)).toList();
    transactions.sort((a,b) =>(a.time.millisecondsSinceEpoch.compareTo(b.time.millisecondsSinceEpoch)));
    return transactions;
  }
}
