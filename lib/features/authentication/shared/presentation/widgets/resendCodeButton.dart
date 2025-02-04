import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/time_constants.dart';

class ResendEmailButton extends StatefulWidget {
  final Duration cooldownDuration;
  final void Function() onTriggered;

  const ResendEmailButton({Key? key, this.cooldownDuration = verificationSpan, required this.onTriggered}) : super(key: key);

  @override
  State<ResendEmailButton> createState() => _ResendEmailButtonState();
}

class _ResendEmailButtonState extends State<ResendEmailButton> {
  Timer _timer = Timer(Duration.zero, () => {});
  int _remainingSeconds = 0;

  bool get _isActive => _remainingSeconds == 0;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _startCooldown();
  }

  void _startCooldown() {
    setState(() => _remainingSeconds = widget.cooldownDuration.inSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
      }
      setState(() => _remainingSeconds--);
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _isActive ? secondary1InvincibleColor : primarily0InvincibleColor;
    final backgroundColor = _isActive ? secondary1InvincibleColor : primarily0InvincibleColor;

    return GestureDetector(
      onTap: () {
        if (_isActive) {
          _startCooldown();
          widget.onTriggered();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer border and main button container
          Container(
            width: 320,
            height: 94,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer rectangle button
                Positioned(
                  top: 18,
                  child: Container(
                    width: 320,
                    height: 57,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    
                  ),
                ),

                // Circular inner white element
                Positioned(
                  top: 0,
                  child: Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: borderColor, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        _isActive ? "Active" : _formatTime(_remainingSeconds),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),

                // Resend label
                const Positioned(
                  left: 29,
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),

                // Email label
                const Positioned(
                  right: 29,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}
