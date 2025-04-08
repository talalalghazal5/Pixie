import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({super.key, required this.onPressed, required this.messageText});
  final Function() onPressed;
  final String messageText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          messageText,
          style: const TextStyle(fontFamily: 'space'),
        ),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: onPressed,
          color: Theme.of(context).colorScheme.secondary.withAlpha(150),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'retryCTA'.tr,
            style: TextStyle(
              fontFamily: 'spaceMedium',
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
