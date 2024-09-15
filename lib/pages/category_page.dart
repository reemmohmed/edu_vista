import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category: $categoryName'),
      ),
      body: Center(
        child: Text('Displaying details for $categoryName category'),
      ),
    );
  }
}
