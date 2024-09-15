import 'dart:developer';

import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/widgets/video_box_widget.dart';
import 'package:flutter/material.dart';

class CourseDetailsPage extends StatelessWidget {
  //TODO: Change this parametar to Course insted of QueryDocumentSnapshot
  final Course course; // الكورس المرسل
  static const String id = 'course_details_page';

  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    //TODO: The description always null here so i give it a value contain Reem, Should modify it in firebase
    course.description ??= 'Please Reem Enter Description In Firebase';
    log("videoooooooo ${course}");
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title ?? 'Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${course.title}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Price: \$${course.price}'),
            const SizedBox(height: 10),
            Text('Description: ${course.description ?? 'No description'}'),
            SizedBox(
              height: 10,
            ),
            VideoBoxWidget(
                url:
                    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
          ],
        ),
      ),
    );
  }
}


























































// import 'package:flutter/material.dart';
// import 'package:edu_vista/models/course.dart';

// class CourseDetailsPage extends StatelessWidget {
//   static const String id = 'course_details_page'; // معرف ثابت لهذه الصفحة

//   final Course course;

//   const CourseDetailsPage({
//     Key? key,
//     required this.course,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(course.title ?? 'Course Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (course.image != null) Image.network(course.image!),
//             const SizedBox(height: 20),
//             Text(
//               course.title ?? 'No Title',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Price: ${course.price?.toStringAsFixed(2) ?? "N/A"} ${course.currency ?? ""}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Rating: ${course.rating?.toStringAsFixed(1) ?? "No Rating"}',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
