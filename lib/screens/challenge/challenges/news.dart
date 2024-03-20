import 'package:flutter/material.dart';
import '../../../models/news_model.dart';
import '../../../widgets/news_card.dart';

class ChallengeNews extends StatelessWidget {
  const ChallengeNews({super.key, required this.headlines});

  final List<String> headlines;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: ListView.builder(
        itemCount: headlines.length,
        itemBuilder: (context, index) {
          return NewsCard(
            news: News(source: NewsSource(id: "", name: ""), author: '', description: '', title: headlines[index], url: '', urlToImage: '', publishedAt: DateTime.fromMillisecondsSinceEpoch(0), content: ''),
            onTap: () {},
          );
        },
      ),
    );
  }
}
