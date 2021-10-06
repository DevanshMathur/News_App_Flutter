import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitledTextWidget extends StatelessWidget {
  final String fieldName;
  final bool isClickable;
  final String? fieldData;

  const TitledTextWidget(this.fieldName, this.isClickable, this.fieldData,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fieldData != null
        ? Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fieldName.isNotEmpty
                ? Text(
                  fieldName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
                : Container(),
                Text(
                  fieldData!,
                  style: isClickable
                      ? const TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        )
                      : const TextStyle(),
                ),
              ],
            ),
          )
        : Container();
  }
}
