import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/course_details_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore

class CoursesPage extends StatelessWidget {
  final String rankValue;

  const CoursesPage({Key? key, required this.rankValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // يظهر سهم الرجوع تلقائيًا

        title:
            Text('Courses: $rankValue'), // عنوان الصفحة بناءً على نوع الكورسات
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('courses') // اسم المجموعة في Firebase
            .where('rank',
                isEqualTo: rankValue) // جلب الكورسات بناءً على القيمة
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // عرض مؤشر تحميل أثناء انتظار البيانات
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child:
                    Text('No courses found')); // عرض رسالة إذا لم توجد كورسات
          }

          // جلب الكورسات وعرضها في قائمة
          var courses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              var course = courses[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(course['title'] ?? 'Untitled'), // عنوان الكورس
                  subtitle: Text('Price: \$${course['price']}'), // سعر الكورس
                  onTap: () {
                    // عند النقر على الكورس، يمكنك الانتقال إلى صفحة تفاصيل الكورس
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseDetailsPage(course: Course.fromJson(course)),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
