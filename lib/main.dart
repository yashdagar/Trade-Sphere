import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'screens/challenge/challenges_list.dart';
import 'screens/leaderboard/leaderboard.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'models/stock_data_model.dart';
import 'models/user_data_model.dart';
import 'screens/news/news.dart';
import 'screens/Stocks/stocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Roboto', // Use a font suitable for trading apps
              textTheme: TextTheme(
                titleMedium: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(color: Color(0xFF121212)),
              textTheme: TextTheme(
                titleMedium: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[400],
                ),
              ),
            ),
            themeMode: ThemeMode.system,
            home: user == null ? LoginPage() : const MyHomePage(),
          );
        }
        return const MaterialApp(home:Scaffold(body: Center(child: CircularProgressIndicator())));
      },);
  }
}

class LoginPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LoginPage({super.key});

  Future<User?> _handleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential authResult = await auth.signInWithCredential(credential);
      
      if(authResult.user != null){
        FirebaseDatabase.instance.ref().child(authResult.user!.uid.toString())
            .set({
          "currency": 1000000.00001,
          "currentWorth": 1000000.00001,
          "name": authResult.user!.displayName,
          "url": authResult.user!.photoURL,
        });
      }
      
      return authResult.user;
    } catch (error) {
      if (kDebugMode) {
        print("ERROR $error");
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/img.png"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async => await _handleSignIn(),
              child: SizedBox(
                width: 200,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sign in with Google'),
                    const SizedBox(width: 8),
                    Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png", width: 20, height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  List<Widget> screens = [
    const StocksScreen(),
    const LeaderboardScreen(),
    const ChallengeListScreen(),
    const NewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.onBackground,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.stats_chart_outline, color: Theme.of(context).colorScheme.onBackground),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.podium_outline, color: Theme.of(context).colorScheme.onBackground),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.trophy_outline, color: Theme.of(context).colorScheme.onBackground),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.newspaper_outline, color: Theme.of(context).colorScheme.onBackground),
            label: 'News',
          ),
        ],
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    setWorth();
  }

  setWorth() async {
    DataSnapshot snapshot = await FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserData userData = UserData.fromSnapshot(snapshot);

    double currentWorth = userData.currentBalance;
    if(userData.stocks.any((stock) => stock.units > 0)) {
      for(Stock stock in userData.stocks){
        if (stock.units > 0) {
          Response response = await Dio().get(
              "https://api.iex.cloud/v1/data/core/quote/${stock
                  .symbol}?filter=latestPrice&token=$stocksApiKey");
          StockData data = StockData.fromJson(response.data[0]);
          currentWorth += data.price * stock.units;
          stock.symbol;
        }
      }
    }
    FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("currentWorth")
        .set(currentWorth);

    FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("name")
        .set(FirebaseAuth.instance.currentUser!.displayName);

    FirebaseDatabase
        .instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("url")
        .set(FirebaseAuth.instance.currentUser!.photoURL);
  }
}