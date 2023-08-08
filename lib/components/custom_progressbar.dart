import 'package:flutter/material.dart';

class CustomProgressBar {
  static showLoader(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            ));
  }

  static cancelLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}
