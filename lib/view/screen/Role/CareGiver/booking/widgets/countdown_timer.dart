import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_health_app/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/style.dart';

class CountUpTimerCard extends StatefulWidget {
  @override
  _CountUpTimerCardState createState() => _CountUpTimerCardState();
}

class _CountUpTimerCardState extends State<CountUpTimerCard> {
  late Timer _timer;
  Duration _elapsedTime = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initializeTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? startTime = prefs.getInt(AppConstants.startTimeKey);

    if (startTime != null) {
      final DateTime savedStartTime = DateTime.fromMillisecondsSinceEpoch(startTime);
      final Duration elapsedSinceSaved = DateTime.now().difference(savedStartTime);
      setState(() {
        _elapsedTime = elapsedSinceSaved;
      });
    } else {
      await _saveStartTime();
    }

    // Start the timer
    _startTimer();
  }

  Future<void> _saveStartTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    await prefs.setInt(AppConstants.startTimeKey, now.millisecondsSinceEpoch);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = Duration(seconds: _elapsedTime.inSeconds + 1);
      });
    });
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.lightPurpleColor,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _formatTime(_elapsedTime),
              style: AppStyles.fontSize32(
                fontWeight: FontWeight.w700,
                color: AppColors.darkGrayColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
