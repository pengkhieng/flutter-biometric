import 'dart:async';

import 'package:flutter/material.dart';

class CustomPinKeyBoard extends StatefulWidget {
  VoidCallback? onPinIsMatch;
  bool? automaticImplyLeading;
  CustomPinKeyBoard({
    super.key,
    this.onPinIsMatch,
    this.automaticImplyLeading,
  });
  @override
  _CustomPinKeyBoardState createState() => _CustomPinKeyBoardState();
}

class _CustomPinKeyBoardState extends State<CustomPinKeyBoard>
    with SingleTickerProviderStateMixin {
  Widget? topChild;
  String pin = '';
  String pinInLocal = '5555';
  int attempts = 0;
  bool isLocked = false;
  int rongTime = 1;
  bool isclick = false;
  bool isclickBio = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  int countdownTimeInSeconds = 1;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: topChild,
            ),
            if (isLocked) ...[
              Text(
                'Incorrect PIN Code Please Try again in ${countdownTimeInSeconds} seconds later!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              )
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: child,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: i < pin.length ? 6 : 0,
                          color:
                              i < pin.length ? Colors.blue : Colors.transparent,
                        ),
                        shape: BoxShape.circle,
                        color: i < pin.length ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 1; i <= 9; i++)
                    NumberButton(
                      number: '$i',
                      onPressed: () {
                        _onNumberPressed('$i');
                        print('This is num : $i');
                      },
                    ),
                  Container(
                    margin: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isclickBio ? Colors.blue : Colors.transparent,
                    ),
                    child: IconButton(
                      onPressed: () {
                        isclickBio = true;
                        _callBiometric();
                        Future.delayed(Duration(milliseconds: 100), () {
                          setState(() {
                            isclickBio = false;
                          });
                        });
                      },
                      icon: Icon(Icons.face),
                      iconSize: 36,
                    ),
                  ),
                  NumberButton(
                    number: '0',
                    onPressed: () {
                      _onNumberPressed('0');
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      _onDeletePressed();
                      isclick = true;
                      Future.delayed(Duration(milliseconds: 100), () {
                        setState(() {
                          isclick = false;
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isclick ? Colors.blue : Colors.transparent,
                      ),
                      child: Icon(Icons.backspace),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _shakeAnimation = Tween(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _shakeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onDeletePressed() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  void _onNumberPressed(String number) {
    if (isLocked) {
      return;
    }
    setState(() {
      if (pin.length < 4) {
        pin += number;
        print('This is PIN : $pin');
      }
      if (pin.length == 4) {
        if (pin == pinInLocal) {
          // ======== use func here =========
          if (widget.onPinIsMatch != null) {
            widget.onPinIsMatch!();
          } else {
            print('No route');
          }
          // ======== ending =========
          print('PIN Code is much');
          rongTime = 1;
        } else {
          setState(() {
            rongTime = rongTime + 1;
            if (rongTime == 20) {
              rongTime = 50;
              isLocked = true;
            } else {
              print(rongTime);
              if (rongTime > 4) {
                isLocked = true;
                startCountdown();
                Future.delayed(Duration(seconds: 5 * rongTime), () {
                  setState(() {
                    isLocked = false;
                  });
                });
              }
            }
          });
        }
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            pin = '';
          });
        });
      }
    });
  }

  void startCountdown() {
    countdownTimeInSeconds = rongTime * 5;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownTimeInSeconds == 0) {
          _timer!.cancel();
        } else {
          countdownTimeInSeconds--;
        }
      });
    });
  }

  void _callBiometric() {
    setState(() {
      print('Show scan faceId');
    });
  }
}

class NumberButton extends StatefulWidget {
  const NumberButton({
    super.key,
    required this.number,
    required this.onPressed,
  });
  final String number;
  final VoidCallback onPressed;

  @override
  _NumberButtonState createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPressed ? Colors.blue.shade400 : Colors.transparent,
        ),
        child: Center(
          child: Text(
            widget.number,
            style: TextStyle(
              fontSize: 32,
              color: isPressed ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
