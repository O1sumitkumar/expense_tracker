import 'package:flutter/material.dart';
import 'package:flutter_hot_toast/flutter_hot_toast.dart';

void showToast(BuildContext context, String message) {
  context.loaderOverlay.show(
    widget: FlutterHotToast.error(
      context,
      height: 70,
      width: 280,
      label: Text(
        message,
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    ),
  );
}
