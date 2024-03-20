import 'package:flutter/material.dart';
import '../models/leaderboard_model.dart';

class LeaderboardCard extends StatelessWidget {
  const LeaderboardCard({super.key, required this.stat});

  final LeaderboardStat stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Text(
          stat.index.toString(),
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(stat.url, width: 36),
        ),
        const SizedBox(width: 16),
        Text(stat.name),
        const Expanded(child: SizedBox()),
        Text("\$${stat.netWorth.toStringAsFixed(2)}"),
      ]),
    );
  }
}