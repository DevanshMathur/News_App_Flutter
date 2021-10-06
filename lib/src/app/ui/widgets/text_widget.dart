import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? fieldData;
  final bool isHeading;

  const TextWidget(this.fieldData, this.isHeading, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fieldData != null
        ? Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            child: Text(
              fieldData as String,
              style: isHeading
                  ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20,
                    )
                  : const TextStyle(),
            ),
          )
        : Container();
  }
}
