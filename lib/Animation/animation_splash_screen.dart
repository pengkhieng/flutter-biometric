import 'package:flutter/material.dart';

class AnimatedPositionedImage extends StatefulWidget {
  const AnimatedPositionedImage({Key? key}) : super(key: key);

  @override
  State<AnimatedPositionedImage> createState() =>
      _AnimatedPositionedImageState();
}

class _AnimatedPositionedImageState extends State<AnimatedPositionedImage> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    // Trigger the animation after a delay when the widget is initialized
    Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - kToolbarHeight * 4,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    top: selected ? 100.0 : 300.0,
                    left: 0,
                    right: 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.orange,
                        child: Text(
                          'Title On Top',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: selected ? 160.0 : 1600.0,
                    left: 0,
                    right: 0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Text(
                          'Description',
                          textAlign: TextAlign.center,
                        ),
                      ),
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
}
