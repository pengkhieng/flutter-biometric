import 'package:biolocalauth/home_page2/home_page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPinKeyBoard extends StatefulWidget {
  const CustomPinKeyBoard({super.key});

  @override
  State<CustomPinKeyBoard> createState() => _CustomPinKeyBoardState();
}

class _CustomPinKeyBoardState extends State<CustomPinKeyBoard> {
  String enteredPin = '';
  String value1 = '';
  String value2 = '';

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (enteredPin.length < 4) {
            enteredPin += number.toString();
          }
          if (enteredPin.length == 4) {
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                enteredPin = '';
              });
            });
          }
          if (enteredPin.length == 4) {
            print(enteredPin);
            if (value1.isEmpty) {
              value1 = enteredPin;
              enteredPin = '';
            } else if (value1.isNotEmpty && value2.isEmpty) {
              if (value1 == enteredPin) {
                value2 = enteredPin;
                print('PINs matched: $value1');
                print("go to next route here");
              } else {
                print('PINs did not match. Try again.');
              }
            }
          }
          print('Value 1: $value1');
          print('Value 2: $value2');
        });
      },
      child: Container(
        color: Colors.amber,
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 1, 40, 197),
              Color.fromARGB(198, 1, 40, 197),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            const Center(
              child: Text(
                'Enter Your Pin',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),

            /// pin code area
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      border: Border.all(
                        width: 2,
                        color: index < enteredPin.length
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      color: index < enteredPin.length
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                for (var i = 0; i < 3; i++)
                  Container(
                    height: 100,
                    margin: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => numButton(1 + 3 * i + index),
                      ).toList(),
                    ),
                  ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  color: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 26,
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => HomePage2(),
                              );
                            },
                            child: const Icon(
                              Icons.face_unlock_sharp,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: numButton(0),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              vertical: 26,
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (enteredPin.isNotEmpty) {
                                      enteredPin = enteredPin.substring(
                                          0, enteredPin.length - 1);
                                    }
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.backspace,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
