import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/MainScreenStatepages/CartPage.dart';
import 'package:edu_vista/MainScreenStatepages/courses_page.dart';
import 'package:flutter/material.dart';
import 'package:edu_vista/pages/course_details_page.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back, User'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartPage();
              }));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Categories',
                  onSeeAllPressed: null,
                ),
                const CategoriesListWidget(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Top Rated Courses',
                  onSeeAllPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CoursesPage(rankValue: 'top rated'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const TopCoursesListWidget(rankValue: 'top rated'),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Top Seller Courses',
                  onSeeAllPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CoursesPage(rankValue: 'top seller'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const TopCoursesListWidget(rankValue: 'top seller'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllPressed;

  const SectionTitle({super.key, required this.title, this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: const Text('See All'),
        ),
      ],
    );
  }
}

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryCard(category: 'Business'),
          CategoryCard(category: 'UI/UX'),
          CategoryCard(category: 'Software Engineering'),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(category),
      ),
    );
  }
}

class TopCoursesListWidget extends StatelessWidget {
  final String rankValue;

  const TopCoursesListWidget({super.key, required this.rankValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<QuerySnapshot>(
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
              log('couuuuuuuuuuuuuuuuuuuuurse ${course.data().toString()}');
              return CourseCard(course: course);
            },
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final QueryDocumentSnapshot course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final courseData = Course.fromJson(
        {'id': course.id, ...course.data() as Map<String, dynamic>});

    log('courseData ${courseData.image}');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(
              //TODO: Give it "course" as Course -> Model, Not as QueryDocumentSnapshot
              course: courseData,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (courseData.image != null && courseData.image!.isNotEmpty)
              Image.network(
                courseData.image ??
                    'https://th.bing.com/th?id=OIP.Ib2hnkro8GuHpCODmCS3-gHaKf&w=209&h=297&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                width: 150,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                      width: 150,
                      fit: BoxFit.fill,
                      height: 100,
                      'https://th.bing.com/th?id=OIP.Ib2hnkro8GuHpCODmCS3-gHaKf&w=209&h=297&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2');
                },
              ),
            if (courseData.image == null || courseData.image!.isEmpty)
              const Text('No Image Available'),
            Text(courseData.title ?? 'No Title'),
            Text('\$${courseData.price?.toStringAsFixed(2) ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}














// MainScreen مع أزرار التنقل
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0; // لتعقب الصفحة الحالية

//   final List<Widget> _pages = [
//     const HomePage(),
//     const CoursesPage(rankValue: 'all'), // تمرير القيمة المناسبة لعرض جميع الكورسات
//     const SearchPage(),
//     const ChatsPage(),
//     const CartPage(),
//     const ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex], // عرض الصفحة بناءً على الزر الذي ينقر عليه المستخدم
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index; // تحديث الصفحة بناءً على الزر الذي ينقر عليه المستخدم
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.black),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book, color: Colors.black),
//             label: 'Courses',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, color: Colors.black),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat, color: Colors.black),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart, color: Colors.black),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Colors.black),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }





















// import 'package:edu_vista/widgets/courses_widget.dart';
// import 'package:edu_vista/widgets/label_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../widgets/categories_widget.dart';
// import 'course_details_page.dart';
// import 'category_page.dart';
// import 'courses_page.dart';

// class HomePage extends StatefulWidget {
//   static const String id = 'home';
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // قسم الفئات
//                 LabelWidget(
//                   name: 'Categories',
//                   onSeeAllClicked: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             const CategoryPage(categoryName: ''),
//                       ),
//                     );
//                   },
//                 ),
//                 CategoriesWidget(
//                   onCategoryClicked: (categoryName) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CategoryPage(categoryName: categoryName),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // قسم "Top Rated Courses"
//                 LabelWidget(
//                   name: 'Top Rated Courses',
//                   onSeeAllClicked: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CoursesPage(rankValue: 'top rated'),
//                       ),
//                     );
//                   },
//                 ),
//                 CoursesWidget(
//                   rankValue: 'top rated',
//                   onCourseClicked: (course) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CourseDetailsPage(
//                           course: course,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // قسم "Top Seller Courses"
//                 LabelWidget(
//                   name: 'Top Seller Courses',
//                   onSeeAllClicked: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             CoursesPage(rankValue: 'top seller'),
//                       ),
//                     );
//                   },
//                 ),
//                 CoursesWidget(
//                   rankValue: 'top seller',
//                   onCourseClicked: (course) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CourseDetailsPage(
//                           course: course,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
























































// import 'package:edu_vista/widgets/categories_widget.dart';
// import 'package:edu_vista/widgets/courses_widget.dart';
// import 'package:edu_vista/widgets/label_widget.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:paymob_payment/paymob_payment.dart';

// class HomePage extends StatefulWidget {
//   static const String id = 'home';
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName}'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               LabelWidget(
//                 name: 'Categories',
//                 onSeeAllClicked: () {},
//               ),
//               CategoriesWidget(
//                 onCategoryClicked: (categoryName) {},
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               LabelWidget(
//                 name: 'Top Rated Courses',
//                 onSeeAllClicked: () {},
//               ),
//               CoursesWidget(
//                 // ignore: non_constant_identifier_names
//                 rankValue: 'top rated', onCourseClicked: (course) {},
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               LabelWidget(
//                 name: 'Top Seller Courses',
//                 onSeeAllClicked: () {},
//               ),
//               CoursesWidget(
//                 rankValue: 'top seller',
//                 onCourseClicked: (course) {},
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     var imageResult = await FilePicker.platform
//                         .pickFiles(type: FileType.image, withData: true);
//                     if (imageResult != null) {
//                       var storageRef = FirebaseStorage.instance
//                           .ref('images/${imageResult.files.first.name}');
//                       var uploadResult = await storageRef.putData(
//                           imageResult.files.first.bytes!,
//                           SettableMetadata(
//                             contentType:
//                                 'image/${imageResult.files.first.name.split('.').last}',
//                           ));

//                       if (uploadResult.state == TaskState.success) {
//                         var downloadUrl =
//                             await uploadResult.ref.getDownloadURL();
//                         print('>>>>>Image upload${downloadUrl}');
//                       }
//                     } else {
//                       print('No file selected');
//                     }
//                   },
//                   child: Text('upload Image')),
//               ElevatedButton(
//                   onPressed: () async {
//                     PaymobPayment.instance.initialize(
//                       apiKey: dotenv.env[
//                           'apiKey']!, // from dashboard Select Settings -> Account Info -> API Key
//                       integrationID: int.parse(dotenv.env[
//                           'integrationID']!), // from dashboard Select Developers -> Payment Integrations -> Online Card ID
//                       iFrameID: int.parse(dotenv.env[
//                           'iFrameID']!), // from paymob Select Developers -> iframes
//                     );

//                     final PaymobResponse? response =
//                         await PaymobPayment.instance.pay(
//                       context: context,
//                       currency: "EGP",
//                       amountInCents: "20000", // 200 EGP
//                     );

//                     if (response != null) {
//                       print('Response: ${response.transactionID}');
//                       print('Response: ${response.success}');
//                     }
//                   },
//                   child: Text('paymob pay'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
