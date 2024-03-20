import 'package:flutter/material.dart';
import 'challenges/challenge_details.dart';

class ChallengeListScreen extends StatefulWidget {
  const ChallengeListScreen({super.key});

  @override
  State<ChallengeListScreen> createState() => _ChallengeListScreenState();
}

class _ChallengeListScreenState extends State<ChallengeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Market Insights Challenge: Historical Scenarios")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Challenge1()));
                },
                child: Card(
                  color: const Color(0xFF121212),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: 1, color: Color(0xFF212429)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Chapter 1",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SizedBox()));
                },
                child: Card(
                  color: const Color(0xFF121212),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: 1, color: Color(0xFF212429)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Chapter 2",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SizedBox()));
                },
                child: Card(
                  color: const Color(0xFF121212),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: 1, color: Color(0xFF212429)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          "Chapter 3",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SizedBox()));
                },
                child: Card(
                  color: const Color(0xFF121212),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(width: 1, color: Color(0xFF212429)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Chapter 4",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
        ]),
      )
    );
  }
}
