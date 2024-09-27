import 'package:flutter/material.dart';

enum Trend { up, down, equal }

class ProgressCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final double progress; // 从 0.0 到 1.0
  final Trend trend;
  final Color backgroundColor;

  const ProgressCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.progress,
    required this.trend,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Icon(widget.icon, size: 40, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ]),
                _buildTrendIcon(widget.trend),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: widget.progress,
              backgroundColor: Colors.black12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendIcon(Trend trend) {
    switch (trend) {
      case Trend.up:
        return const Icon(Icons.arrow_upward, color: Colors.black);
      case Trend.down:
        return const Icon(Icons.arrow_downward, color: Colors.black);
      case Trend.equal:
        return const Icon(Icons.remove, color: Colors.black);
    }
  }
}
