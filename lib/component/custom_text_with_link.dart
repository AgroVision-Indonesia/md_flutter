import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:md_flutter/utility/helper.dart';

class CustomTextWithLink extends StatefulWidget {
  const CustomTextWithLink({
    Key? key,
    required this.text,
    this.textColor = Colors.black,
    this.textWeight = FontWeight.w500,
    this.linkColor = Colors.blue,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final FontWeight textWeight;
  final Color linkColor;

  @override
  State<CustomTextWithLink> createState() => _CustomTextWithLinkState();
}

class _CustomTextWithLinkState extends State<CustomTextWithLink> {
  List<InlineSpan> spans = [];
  String text = '';

  @override
  void initState() {
    text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Pecah teks menjadi beberapa bagian
    RegExp exp = RegExp(r'https?:\/\/[^\s]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);
    int start = 0;
    for (RegExpMatch match in matches) {
      // Tambahkan bagian teks sebelum tautan
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: TextStyle(
            color: widget.textColor,
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            fontWeight: widget.textWeight,
          ),
        ));
      }

      // Tambahkan tautan
      String? url = match.group(0);
      spans.add(
        TextSpan(
          text: url,
          style: TextStyle(
            color: widget.linkColor,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Helper(context: context).launchURL(url);
              // helper(context: context).openWebview(url: url);
            },
        ),
      );

      // Set posisi awal untuk bagian teks berikutnya
      start = match.end;
    }

    // Tambahkan bagian teks terakhir
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(
          color: widget.textColor,
          fontSize: 14,
          fontWeight: widget.textWeight,
          fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
        ),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
