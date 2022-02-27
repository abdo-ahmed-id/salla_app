import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/alert_dialog.dart';

class Notifications {
  static Widget loading() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.black.withOpacity(.8),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static bool isOverlay = false;
  static success(String message, {int time}) =>
      showSnackBar(content: message, backgroundColor: Colors.green, time: time);

  static error(String message) => showSnackBar(
        content: message,
        backgroundColor: Colors.red,
      );

  static showLoading() {
    isOverlay = true;
    asuka.addOverlay(loadingOverLay);
  }

  static hideLoading() {
    if (isOverlay) {
      loadingOverLay.remove();
      isOverlay = false;
    }
  }

  static OverlayEntry loadingOverLay = OverlayEntry(
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.black.withOpacity(.8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
  static showSnackBar(
      {String content, Color textColor, Color backgroundColor, int time}) {
    asuka.showSnackBar(SnackBar(
      content: Text(
        content ?? '',
        style: GoogleFonts.cairo(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.black26,
      duration: Duration(seconds: time ?? 1),
    ));
  }

  static confirmDialog(BuildContext context,
      {String title,
      String content,
      String cancelText,
      String confirmText,
      VoidCallback onConfirm,
      VoidCallback onCancel,
      bool dismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      useRootNavigator: false,
      builder: (_) => alertDialog(
        context: context,
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  static dialog(BuildContext context,
          {Widget child, bool dismissible = true}) =>
      showDialog(
          context: context,
          barrierDismissible: dismissible,
          useRootNavigator: false,
          builder: (_) => child);
}
