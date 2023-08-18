// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class HashTags_Links extends StatelessWidget {
  final String text;
  const HashTags_Links({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspan = [];

    text.split(' ').forEach((word) {
      if (word.startsWith('#')) {
        textspan.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(
                color: Pallete.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        );
      } else if (word.startsWith('www.') || word.startsWith('https://')) {
        textspan.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(color: Pallete.blueColor, fontSize: 18),
          ),
        );
      } else {
        textspan.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(color: Pallete.whiteColor, fontSize: 18),
          ),
        );
      }
    });
    return RichText(
      text: TextSpan(
        children: textspan,
      ),
    );
  }
}
