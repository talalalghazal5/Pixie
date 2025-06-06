import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/view/results_page.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      child: TextField(
        style: const TextStyle(
          fontFamilyFallback: ['sfArabic'],
          fontFamily: 'space',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.inversePrimary.withAlpha(50),
          hintText: 'inputFieldHint'.tr,
          hintStyle: TextStyle(
            fontFamilyFallback: const ['sfArabic'],
            fontFamily: 'space',
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 14,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FaIcon(
              FontAwesomeIcons.wandMagicSparkles,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        cursorColor: Theme.of(context).colorScheme.inversePrimary,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultsPage(
                  query: value,
                ),
                allowSnapshotting: true,
              ),
            );
          }
        },
      ),
    );
  }
}
