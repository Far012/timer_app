import 'package:flutter/material.dart';
import 'timer.dart';
import 'stopwatch.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  HomeNavigationState createState() => HomeNavigationState();
}

class HomeNavigationState extends State<HomeNavigation> {
  int selectedIndex = 0;

  void onTapped(int index) => setState(() => selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [TimerWidget(), StopwatchWidget()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer),
            label: "Stoppuhr",
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onTapped,
      ),
    );
  }
}
