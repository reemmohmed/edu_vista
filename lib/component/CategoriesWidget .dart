import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edu_vista/models/category.dart';

class CategoriesWidget extends StatefulWidget {
  final Function(String) onCategoryClicked;

  const CategoriesWidget({Key? key, required this.onCategoryClicked})
      : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _fetchCategories();
  }

  Future<List<Category>> _fetchCategories() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    return snapshot.docs
        .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading categories'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        List<Category> categories = snapshot.data!;

        return Wrap(
          spacing: 10,
          children: categories.map((category) {
            return GestureDetector(
              onTap: () {
                widget.onCategoryClicked(category.name!);
              },
              child: Chip(
                label: Text(category.name!),
                backgroundColor: Colors.blue[100],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
