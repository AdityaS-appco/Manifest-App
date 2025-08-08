import 'package:flutter/material.dart';
import 'package:manifest/helper/constant.dart';

class RoudedSheetCloseButton extends StatelessWidget {
  const RoudedSheetCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 0.14, right: 22.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(127, 127, 127, 0.4),
                borderRadius: BorderRadius.circular(500),
              ),
              child: Center(
                child: Icon(
                  size: 16.0,
                  Icons.close,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ));
  }
}
