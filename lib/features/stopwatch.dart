import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  StopwatchPageState createState() => StopwatchPageState();
}

class StopwatchPageState extends State<StopwatchWidget> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final time = _formatDuration(stopwatch.elapsed);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stoppuhr",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
      ),

      body: Container(
        color: Color(0xFF333333),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
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
                    onPressed: _start,
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
                    onPressed: _stop,
                    child: Icon(Icons.stop, color: Colors.white, size: 28),
                  ),
                  // Reset-Button
                  CupertinoButton(
                    color: Colors.red,
                    padding: EdgeInsets.all(16),
                    onPressed: _reset,
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

  // Formatiert Duration in MM:SS:MS
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, "0");
    final millis = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(
      2,
      "0",
    );
    return "$minutes:$seconds:$millis";
  }

  // Startet die Stoppuhr
  void _start() {
    if (!stopwatch.isRunning) {
      stopwatch.start();
      // Timer für UI-Updates alle 30ms
      timer = Timer.periodic(Duration(milliseconds: 30), (_) {
        setState(() {});
      });
    }
  }

  // Stoppt die Stoppuhr
  void _stop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      timer?.cancel();
    }
  }

  // Setzt die Stoppuhr zurück
  void _reset() {
    stopwatch.reset();
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
