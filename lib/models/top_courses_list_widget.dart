import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/MainScreenStatepages/home_page.dart';
import 'package:flutter/material.dart';

class TopCoursesListWidget extends StatelessWidget {
  final String rankValue;

  const TopCoursesListWidget({required this.rankValue});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('courses')
          .where('rank', isEqualTo: rankValue)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No courses found.'));
        }

        var courses = snapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            var course = courses[index];
            return CourseCard(course: course);
          },
        );
      },
    );
  }
}
