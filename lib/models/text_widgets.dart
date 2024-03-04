
import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
    required this.text,
  });

  final textStyleSubtitle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyleSubtitle,
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.text,
  });

  final textStyleHeading = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyleHeading,
    );
  }
}
