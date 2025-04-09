import 'package:flutter/material.dart';

class PixieLogoText extends StatelessWidget {
  const PixieLogoText({super.key, this.fontSize});
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Pixie',
      style: TextStyle(
        fontFamily: 'yesterday',
        fontSize: fontSize ?? 30,
        color: Theme.of(context).colorScheme.inversePrimary.withAlpha(100),
      ),
    );
  }
}
