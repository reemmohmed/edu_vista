import 'package:edu_vista/MainScreenStatepages/CartPage.dart';
import 'package:edu_vista/MainScreenStatepages/chat_page.dart';
import 'package:edu_vista/MainScreenStatepages/home_page.dart';
import 'package:edu_vista/MainScreenStatepages/profile_page.dart';
import 'package:edu_vista/MainScreenStatepages/saerch_page.dart';
import 'package:edu_vista/MainScreenStatepages/splash_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    SplashScreen(),
    // const CoursesPage(rankValue: 'all'),
    const SearchPage(),
    const ChatsPage(),

    CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.black),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}




































// import 'package:edu_vista/pages/cart_page.dart';
// import 'package:edu_vista/pages/chat_page.dart';
// import 'package:edu_vista/pages/courses_page.dart';
// import 'package:edu_vista/pages/home_page.dart';
// import 'package:edu_vista/pages/profile_page.dart';
// import 'package:edu_vista/pages/saerch_page.dart';
// import 'package:flutter/material.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0; // لتعقب الصفحة الحالية

//   final List<Widget> _pages = [
//     const HomePage(),
//     const CoursesPage(
//         rankValue: 'all'), // تمرير القيمة المناسبة لعرض جميع الكورسات
//     SearchPage(),
//     const ChatsPage(),
//     const CartPage(),
//     const ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[
//           _currentIndex], // عرض الصفحة بناءً على الزر الذي ينقر عليه المستخدم
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex =
//                 index; // تحديث الصفحة بناءً على الزر الذي ينقر عليه المستخدم
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
