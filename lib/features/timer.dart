import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerWidget> {
  int _seconds = 0;
  int _remaining = 0;
  bool _isRunning = false;
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    // Formatiert Zeit in MM:SS
    final hours = (_remaining ~/ 3600).toString().padLeft(2, "0");
    final minutes = ((_remaining % 3600) ~/ 60).toString().padLeft(2, "0");
    final seconds = (_remaining % 60).toString().padLeft(2, "0");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
      ),

      body: Container(
        color: Color.fromARGB(255, 82, 82, 82),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Cupertino Timer-Picker
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: Duration(seconds: _seconds),
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      _seconds = newDuration.inSeconds;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              // Timer
              Text(
                "$hours:$minutes:$seconds",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Start-Button
                  CupertinoButton(
                    color: Colors.green,
                    padding: EdgeInsets.all(16),
                    onPressed: _startTimer,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  // Stop-Button
                  CupertinoButton(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.all(16),
                    onPressed: _stopTimer,
                    child: Icon(Icons.stop, color: Colors.white, size: 28),
                  ),
                  // Reset-Button
                  CupertinoButton(
                    color: Colors.red,
                    padding: EdgeInsets.all(16),
                    onPressed: _resetTimer,
                    child: Icon(Icons.refresh, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Speichert Timer-Kontext
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _context = context;
    });
  }

  // Startet Timer
  void _startTimer() async {
    if (_isRunning || _seconds <= 0) return;
    setState(() {
      _remaining = _seconds;
      _isRunning = true;
    });

    while (_isRunning && _remaining > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_isRunning) break;
      setState(() => _remaining--);
    }

    if (_remaining <= 0) {
      setState(() {
        _isRunning = false;
        _remaining = 0;
      });
      // SnackBar bei Ablauf
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(
          content: Text("Timer abgelaufen!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Timer stop
  void _stopTimer() {
    setState(() => _isRunning = false);
  }

  // Timer zurück
  void _resetTimer() {
    setState(() {
      _remaining = 0;
      _isRunning = false;
    });
  }
}
