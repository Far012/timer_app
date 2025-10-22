import 'package:flutter/material.dart';
import 'package:timer_app/features/home.dart';

void main() {
  runApp(const TimerStopwatchApp());
}

class TimerStopwatchApp extends StatelessWidget {
  const TimerStopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeNavigation());
  }
}
