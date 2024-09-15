import 'package:edu_vista/MainScreenStatepages/CartPage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // إخفاء زر الرجوع الافتراضي
        backgroundColor: Colors.white, // لون الخلفية أبيض كما في الصورة
        elevation: 0, // إزالة الظل
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search..',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                // نشيط ��نشا�� ��فحة السلة
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم Trending
            const Text(
              'Trending',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text('IT'),
                ),
                Chip(
                  label: Text('Software Engineering'),
                ),
                Chip(
                  label: Text('Amazon'),
                ),
                Chip(
                  label: Text('SEO'),
                ),
                Chip(
                  label: Text('UI/UX'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // قسم Based on your Search
            const Text(
              'Based on your Search',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text('IT'),
                ),
                Chip(
                  label: Text('Software Engineering'),
                ),
                Chip(
                  label: Text('Amazon'),
                ),
                Chip(
                  label: Text('SEO'),
                ),
                Chip(
                  label: Text('UI/UX'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
