import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeScreen extends StatefulWidget {
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String _pinCode = '';
  late Timer _timer;
  DateTime? _lockoutTime;
  int _remainingTimeInSeconds = 0;
  int _attemptCount = 1;

  @override
  void initState() {
    super.initState();
    _loadLockoutTime();
    _timer = Timer.periodic(Duration(seconds: 1), _updateRemainingTimeCallback);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _loadLockoutTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lockoutTimeString = prefs.getString('lockout_time');
    if (lockoutTimeString != null) {
      _lockoutTime = DateTime.parse(lockoutTimeString);
      _updateRemainingTime();
    }
  }

  void _saveLockoutTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_lockoutTime != null) {
      await prefs.setString('lockout_time', _lockoutTime!.toIso8601String());
    }
  }

  void _updateRemainingTime() {
    if (_lockoutTime != null) {
      int differenceInSeconds =
          _lockoutTime!.difference(DateTime.now()).inSeconds;
      if (differenceInSeconds > 0) {
        setState(() {
          _remainingTimeInSeconds = differenceInSeconds;
        });
      } else {
        setState(() {
          _lockoutTime = null;
          _remainingTimeInSeconds = 0;
        });
      }
    }
  }

  void _updateRemainingTimeCallback(Timer timer) {
    _updateRemainingTime();
  }

  void _checkPinCode(String enteredPin) {
    if (enteredPin == '1234') {
      // Correct pin code entered
      // Clear lockout time
      _lockoutTime = null;
      _saveLockoutTime();
      // Proceed to next screen
    } else {
      // Incorrect pin code entered
      if (_lockoutTime == null) {
        // Reset lockout time only if not already locked out
        _lockoutTime = DateTime.now().add(Duration(seconds: 5));
      } else {
        // If already locked out, check if enough time has passed
        if (DateTime.now().isAfter(_lockoutTime!.add(Duration(seconds: 5)))) {
          // Enough time has passed, reset lockout
          _lockoutTime = null;
        } else {
          // Still within lockout period, increment attempt count
          _attemptCount++;
          if (_attemptCount >= 4) {
            // If attempt count exceeds 4, set lockout time
            _lockoutTime = DateTime.now().add(Duration(seconds: 5));
            _attemptCount = 0; // Reset attempt count after lockout
          }
        }
      }
      _saveLockoutTime();
    }
  }

  bool _isLockedOut() {
    return _lockoutTime != null && DateTime.now().isBefore(_lockoutTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Code Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_remainingTimeInSeconds > 0)
              Text('Remaining Time: $_remainingTimeInSeconds seconds'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _pinCode = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Pin Code',
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!_isLockedOut()) {
                  _checkPinCode(_pinCode);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Locked Out'),
                        content: Text('You are temporarily locked out.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
