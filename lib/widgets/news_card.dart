import 'package:flutter/material.dart';

import '../models/news_model.dart';
import 'package:timeago/timeago.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onTap;

  const NewsCard({super.key, required this.news, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              news.urlToImage,
              height: 72.0,
              width: 72.0,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 2, // Adjust the value based on your preference
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news.source.name,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      if(news.publishedAt.millisecondsSinceEpoch != 0)
                      Text(
                        format(news.publishedAt),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}