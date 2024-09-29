import 'package:flutter/material.dart';
import 'dart:async';

class QuoteCard extends StatefulWidget {
  final List<Map<String, String>> quotes;

  QuoteCard({required this.quotes});

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard>
    with SingleTickerProviderStateMixin {
  int _currentQuoteIndex = 0;
  bool _isAutoSwitching = true;
  Timer? _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _startAutoSwitch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startAutoSwitch() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isAutoSwitching) {
        _animationController.forward().then((_) {
          _animationController.reverse();
          _nextQuote();
        });
      }
    });
  }

  void _toggleAutoSwitch() {
    setState(() {
      _isAutoSwitching = !_isAutoSwitching;
    });
  }

  void _nextQuote() {
    setState(() {
      _currentQuoteIndex = (_currentQuoteIndex + 1) % widget.quotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuote = widget.quotes[_currentQuoteIndex];

    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuote['quote'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '- ${currentQuote['author']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: _isAutoSwitching ? -0.05 : 0.00, end: 0.05)
                          .chain(CurveTween(curve: Curves.elasticIn))
                          .animate(_animationController),
                      child: IconButton(
                        icon: Icon(_isAutoSwitching ? Icons.notifications_active : Icons.stop_circle_outlined),
                        onPressed: _toggleAutoSwitch,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: _nextQuote,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
