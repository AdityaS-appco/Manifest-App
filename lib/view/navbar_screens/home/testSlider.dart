import 'package:flutter/material.dart';
import 'package:manifest/helper/constant.dart';

///correct use
class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyCustomSlider(),
    );
  }
}

class MyCustomSlider extends StatefulWidget {
  const MyCustomSlider({super.key});

  @override
  _MyCustomSliderState createState() => _MyCustomSliderState();
}

class _MyCustomSliderState extends State<MyCustomSlider> {
  double _sliderValue = 2.0;
  double _containerWidth = 200; // Initial width of the container
  final double _thumbSize = 10; // Size of the thumb

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              // Update the position of the container based on horizontal drag
              _containerWidth += details.delta.dx;
              if (_containerWidth < 0) {
                _containerWidth = 0;
              } else if (_containerWidth > MediaQuery.of(context).size.width) {
                _containerWidth = MediaQuery.of(context).size.width;
              }

              // Calculate the slider value based on container position
              _sliderValue =
                  _containerWidth / MediaQuery.of(context).size.width;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width -
                  _thumbSize, // Width of the slider track
              height: 35,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: _containerWidth,
                    height: 35,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    left: _containerWidth - _thumbSize / 0.6,
                    top: 3,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _containerWidth += details.delta.dx;
                          if (_containerWidth < 0) {
                            _containerWidth = 0;
                          } else if (_containerWidth >
                              MediaQuery.of(context).size.width - _thumbSize) {
                            _containerWidth =
                                MediaQuery.of(context).size.width - _thumbSize;
                          }
                          _sliderValue = _containerWidth /
                              MediaQuery.of(context).size.width;
                        });
                      },
                      child: Container(
                        width: _thumbSize,
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.black, // Color of the thumb
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(height: 25),
        // Text('Slider Value: $_sliderValue'),

        // CustomSliderWidget(),
      ],
    );
  }
}

class testing2 extends StatefulWidget {
  const testing2({super.key});

  @override
  State<testing2> createState() => _testing2State();
}

class _testing2State extends State<testing2> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _onScroll();
      });
    super.initState();
  }

  double _scrollOffset = 0.0;

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
