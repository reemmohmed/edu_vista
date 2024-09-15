import 'package:edu_vista/MainScreenStatepages/CartPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const String id = 'profile_page';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));

              // Action when shopping cart is clicked
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // صورة المستخدم الشخصية
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // رابط الصورة الشخصية
                    ),
                    const SizedBox(height: 10),
                    // اسم المستخدم
                    const Text(
                      'Muhammad Rafey',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // البريد الإلكتروني
                    const Text(
                      'muhammadarafey999@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // الخيارات الموجودة في الصفحة
              Expanded(
                child: ListView(
                  children: [
                    _buildProfileOption(
                      title: 'Edit',
                      icon: Icons.edit,
                      onTap: () {
                        // هنا يمكن تنفيذ وظيفة تعديل الحساب
                      },
                    ),
                    _buildProfileOption(
                      title: 'Setting',
                      icon: Icons.settings,
                      onTap: () {
                        // هنا يمكن تنفيذ وظيفة إعدادات
                      },
                    ),
                    _buildProfileOption(
                      title: 'Achievements',
                      icon: Icons.star,
                      onTap: () {
                        // هنا يمكن تنفيذ وظيفة الإنجازات
                      },
                    ),
                    _buildProfileOption(
                      title: 'About Us',
                      icon: Icons.info,
                      onTap: () {
                        // هنا يمكن تنفيذ معلومات عن التطبيق
                      },
                    ),
                    const SizedBox(height: 10),
                    // خيار "Logout"
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // هنا يمكن تنفيذ وظيفة تسجيل الخروج
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget لإنشاء تصميم الخيار بشكل Card
  Widget _buildProfileOption(
      {required String title,
      required IconData icon,
      required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200, // اللون الخلفي الخفيف
          borderRadius: BorderRadius.circular(10), // الزوايا الدائرية
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: Icon(icon, color: Colors.grey.shade700),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}






















// class ProfilePage extends StatefulWidget {
//   static const String id = 'profile_page';
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String? _imageUrl;

//   Future<void> _uploadProfilePicture() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);
//     if (result != null) {
//       final file = result.files.first;
//       final storageRef =
//           FirebaseStorage.instance.ref('profile_pictures/${file.name}');
//       final uploadTask = storageRef.putData(file.bytes!);

//       final snapshot = await uploadTask;
//       final downloadUrl = await snapshot.ref.getDownloadURL();

//       setState(() {
//         _imageUrl = downloadUrl;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: Column(
//         children: [
//           if (_imageUrl != null)
//             Image.network(_imageUrl!)
//           else
//             const Text('No Profile Image'),
//           ElevatedButton(
//             onPressed: _uploadProfilePicture,
//             child: const Text('Upload Profile Picture'),
//           ),
//         ],
//       ),
//     );
//   }
// }