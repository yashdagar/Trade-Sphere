import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../../constants.dart';
import '../../../models/search_results_model.dart';
import '../../../widgets/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? timer;
String query = "NASDAQ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? AppBar(
                leading: IconButton(
                  icon: const Icon(Ionicons.arrow_back_outline, size: 20),
                  onPressed: () => setState(() => _isSearching = false),
                ),
                title: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) {
                    timer = Timer(const Duration(seconds: 2), () {
                      setState(() => query = value);
                      timer?.cancel();
                    });
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Ionicons.close_outline),
                    onPressed: () => setState(() {
                      searchController.text = "";
                      query = "AAPL";
                    }),
                  ),
                ],
              )
          : AppBar(
                title: const Text('Stocks'),
                actions: [
                  IconButton(
                    icon: const Icon(Ionicons.search_outline),
                    onPressed: () => setState(() => _isSearching = true),
                  ),
                ],
              ),
      body: Builder(builder: (BuildContext context) {return FutureBuilder(
          future: getStocks(query),
      builder: (BuildContext context, AsyncSnapshot data) {
          if (data.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (!data.hasData || data.data.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("images/not_found_404.svg", height: 160),
                  const SizedBox(height: 16.0),
                  Text('No results found.', style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
            );
          }
          return GridView.builder(
            itemCount: data.hasData ? data.data.length : 0,
            itemBuilder: (context, index) => SearchCard(result: data.data[index]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
          );
        },
      );}),
    );
  }

  Future<List<SearchResults>> getStocks(String query) async {
    Response response = await Dio().get("https://api.iex.cloud/v1/search/$query?token=$stocksApiKey");
    List<SearchResults> stocks = (response.data as List).map<SearchResults>((e) => SearchResults.fromJson(e)).toList();
    return stocks;
  }
}