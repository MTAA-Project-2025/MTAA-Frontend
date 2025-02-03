import 'dart:async';
import 'package:flutter/material.dart';

class DotLoader extends StatefulWidget {
  const DotLoader({super.key});

  @override
  _DotLoaderState createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader> {
  late List<Color> colors;
  int _currentIndex = 0;
  Timer? _colorChangeTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize colors based on current theme
    colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];

    // Initialize timer if not already running
    _colorChangeTimer ??= Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % colors.length;
      });
    });
  }

  @override
  void dispose() {
    _colorChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left block of circles
        Row(
          children: List.generate(3, (index) {
            int colorIndex = (_currentIndex + (2 - index)) % colors.length;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors[colorIndex],
                borderRadius: BorderRadius.circular(9999),
              ),
            );
          }),
        ),
        const SizedBox(width: 24), // Space between the two blocks
        // Right block of circles
        Row(
          children: List.generate(3, (index) {
            int colorIndex = (_currentIndex + index) % colors.length;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors[colorIndex],
                borderRadius: BorderRadius.circular(9999),
              ),
            );
          }),
        ),
      ],
    );
  }
}