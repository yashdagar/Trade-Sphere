import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isSearching = false;
  String text = "Stocks";
  TextEditingController searchController = TextEditingController();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching ? AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _isSearching = false),
        ),
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onChanged: (String value) {
            timer = Timer(const Duration(seconds: 1), () {
              setState(() => text = value);
              timer = null;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() {
              searchController.text = "";
              text = "Stocks";
            }),
          ),
        ],
      ):
      AppBar(
        title: const Text('NEWS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => setState(() => _isSearching = true),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(future: getNews(text), builder: (BuildContext context, AsyncSnapshot<List<News>> news){
          if(news.connectionState == ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator());
          }
          else if(news.hasError){
            if (kDebugMode) {
              print(news.error.toString());
            }
            return Text(news.error.toString(), style: const TextStyle(fontSize: 36));
          }
          else if(!news.hasData || news.data!.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sentiment_dissatisfied,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20.0),
                  Text('No results found.', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }
          return  ListView.builder(
            itemCount: news.hasData? news.data?.length : 0,
            itemBuilder: (context, index) {
              return NewsCard(news: news.data![index], onTap: () => openURL(news.data![index].url));
            },
          );
        }),
      ),
    );
  }

  Future<List<News>> getNews(String query) async {
    Response response = await Dio().get("https://newsapi.org/v2/everything?q=$query&from=2024-01-25&pageSize=20&sortBy=publishedAt&apiKey=$newsApiKey");
    List<News> news = (response.data["articles"] as List).map<News>((e) => News.fromJson(e)).toList();
    return news;
  }

  void openURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}