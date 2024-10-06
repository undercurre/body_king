import 'package:flutter/material.dart';
import 'dart:async';

class QuoteCard extends StatefulWidget {
  final List<Map<String, String>> quotes;

  QuoteCard({required this.quotes});

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> with SingleTickerProviderStateMixin {
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

    if (widget.quotes.isNotEmpty) {
      _startAutoSwitch();
    }
  }

  @override
  void didUpdateWidget(QuoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.quotes != oldWidget.quotes) {
      _resetAutoSwitch();
    }
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

  void _resetAutoSwitch() {
    _timer?.cancel();
    _currentQuoteIndex = 0;
    _startAutoSwitch();
  }

  void _toggleAutoSwitch() {
    setState(() {
      _isAutoSwitching = !_isAutoSwitching;
    });
  }

  void _nextQuote() {
    setState(() {
      _currentQuoteIndex = widget.quotes.length != 0 ? (_currentQuoteIndex + 1) % widget.quotes.length : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quotes.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          height: 180,
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '没有找到您的留言！',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }

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
                  '- ${currentQuote['desc']}',
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
