import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pixie/UI/view/results_page.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      child: TextField(
        style: const TextStyle(fontFamily: 'space',),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey.withAlpha(100),
          hintText: 'Search anything',
          hintStyle: const TextStyle(fontFamily: 'space', color: Colors.grey, fontSize: 14),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const FaIcon(FontAwesomeIcons.wandMagicSparkles, color: Colors.grey,),
          ), // TODO: EDIT THE CURSOR COLOR WHEN SETTING THEMES.
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
             Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(query: value,),allowSnapshotting: true));
          }
        },
      ),
    );
  }
}