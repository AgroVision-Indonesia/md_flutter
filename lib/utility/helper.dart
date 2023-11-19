import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  Helper({required this.context});

  final BuildContext context;

  launchURL(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      if (url.contains("youtube")) {
        final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false, multiLine: false);
        if (regex.hasMatch(url)) {
          String videoId = regex.firstMatch(url)!.group(1) as String;
          ("videoId = $videoId");
          return Navigator.of(context).pushNamed('/universalWebviewPage', arguments: videoId);
        } else {
          ("Cannot parse $url");
          return false;
        }
      }
      return await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showToast({
    required String message,
    Color backgroundColor = Constant.greenMedium,
    Color messageColor = Colors.white,
    Color borderColor = Colors.white,
    Widget? icon,
  }) {
    Flushbar(
      icon: icon,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 72),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderColor: borderColor,
      borderRadius: BorderRadius.circular(8),
      message: message,
      messageColor: messageColor,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
    ).show(context);
  }
}
