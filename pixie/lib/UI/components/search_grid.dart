import 'package:flutter/material.dart';
import 'package:pixie/UI/components/category_card.dart';
import 'package:pixie/data/models/search_category.dart';

class SearchGrid extends StatelessWidget {
  const SearchGrid({super.key, required this.queries});
  final List<Map<String, String>> queries;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // childAspectRatio: 1.7,
          mainAxisExtent: 100
        ),
        itemCount: queries.length,
        itemBuilder: (context, index) {
          SearchCategory category = SearchCategory(
            queries[index]['name']!,
            queries[index]['imagePath']!,
          );
          return CategoryCard(searchCategory: category);
        },
      ),
    );
  }
}
