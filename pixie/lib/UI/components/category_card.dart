import 'package:flutter/material.dart';
import 'package:pixie/UI/view/results_page.dart';
import 'package:pixie/data/models/search_category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.searchCategory});
  final SearchCategory searchCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(query: searchCategory.name!,),)); /// TODO: REPLACE THE PAGE W/ RESULTS PAGE.
      },
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                searchCategory.imagePath!,
                fit: BoxFit.cover,
                width: 4000,
              ),
            ),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(85),
                ),
                child: Text(
                  searchCategory.name!,
                  style: const TextStyle(
                      fontFamily: 'space',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
