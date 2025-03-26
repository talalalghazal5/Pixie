import 'package:flutter/material.dart';
import 'package:pixie/UI/components/search_grid.dart';
import 'package:pixie/UI/components/search_text_field.dart';
import 'package:pixie/controllers/categories_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchTextField(),
            const SizedBox(
              height: 50,
            ),
            Text(
              'You might like',
              style: TextStyle(fontFamily: 'space', fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 20,
            ),
            SearchGrid(queries: CategoriesController.categories),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Search by colors',
              style: TextStyle(fontFamily: 'space', fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 20,
            ),
            SearchGrid(queries: CategoriesController.colors),
          ],
        ),
      ),
    );
  }
}
