import 'package:flutter/material.dart';
import 'package:manifest/helper/constant.dart';


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
              _sliderValue = _containerWidth / MediaQuery.of(context).size.width;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - _thumbSize, // Width of the slider track
              height: 35,
              decoration: BoxDecoration(
                color: inActiveSliderBgColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: _containerWidth,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color.fromRGBO(162, 141, 246, 1),Color.fromRGBO(123, 108, 184, 1),],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
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
                          } else if (_containerWidth > MediaQuery.of(context).size.width - _thumbSize) {
                            _containerWidth = MediaQuery.of(context).size.width - _thumbSize;
                          }
                          _sliderValue = _containerWidth / MediaQuery.of(context).size.width;
                        });
                      },
                      child: Container(
                        width: _thumbSize,
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Color.fromRGBO(58, 58, 60, 1), // Color of the thumb
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




