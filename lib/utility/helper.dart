import 'package:flutter/material.dart';
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
}
