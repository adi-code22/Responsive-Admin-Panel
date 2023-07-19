import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String msg;
  final String? content;

  const CustomAlertDialog({
    Key? key,
    required this.msg,
    this.content,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(msg),
      content: Text(content ?? ""),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: secondaryColor,
            padding: const EdgeInsets.all(14),
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}
