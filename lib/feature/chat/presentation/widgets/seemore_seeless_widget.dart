import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/themes/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SeeMoreSeeLessWidget extends StatelessWidget {
  const SeeMoreSeeLessWidget({
    super.key,
    required this.text,
    required this.isExpanded,
    this.onTap,
    this.color,
  });

  final String text;
  final bool isExpanded;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textStyle = Styles.style16400.copyWith(color: color ?? Colors.white);
    final linkStyle = textStyle.copyWith(
      color: Colors.white,
      decoration: TextDecoration.underline,
    );

    // Updated regular expression to handle URLs better, including query parameters
    final urlRegex = RegExp(
      r'(https?:\/\/[^\s]+)',
      caseSensitive: false,
    );

    TextSpan buildTextSpan(String text) {
      final List<InlineSpan> children = [];

      text.splitMapJoin(
        urlRegex,
        onMatch: (Match match) {
          final String url = match.group(0)!;
          children.add(
            TextSpan(
              text: url,
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  } else {
                    print('Could not launch $url');
                  }
                },
            ),
          );
          return url;
        },
        onNonMatch: (String nonMatch) {
          children.add(
            TextSpan(
              text: nonMatch,
              style: textStyle,
            ),
          );
          return nonMatch;
        },
      );

      return TextSpan(children: children);
    }

    if (text.length <= 100) {
      return RichText(
        text: buildTextSpan(text),
      );
    } else if (isExpanded) {
      return RichText(
        text: TextSpan(
          children: [
            buildTextSpan(text),
            TextSpan(
              text: ' ',
              style: textStyle,
              children: [
                TextSpan(
                  text: 'show less',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          children: [
            buildTextSpan(text.substring(0, 100)),
            TextSpan(
              text: '... ',
              style: textStyle,
              children: [
                TextSpan(
                  text: 'see more',
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
